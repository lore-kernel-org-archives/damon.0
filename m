Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD087E
	for <damon@lists.linux.dev>; Thu, 20 Oct 2022 00:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7B7C433C1;
	Thu, 20 Oct 2022 00:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666226626;
	bh=Peq0KHQrn5t+CTE8DMNOFhtTgSoud1yIjBc6vJfT0LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5xX2GMZ9QjNa9pQ8Kf8StLkWW5ASVOfaCQGMEcvp1bPZyDKt7+TP53efrITYXy8i
	 xzKJjzZ9WPZpQvstA2gWpRndWYWw/XKHUuo8z3DRzmEIB/Q4Dn+LtpAXNeQ44JBYb+
	 ztExFn8YS2LgmMKAYf/jVJWKVYF1MnRTv1BQpAVnJS0qCI6DIWrwis1emQPsBY6SJR
	 dez5qydufauqTF3xLyFKHjlD6KRrgepr/ye1a6OwN5oC7UC8ERGaMdHBXwgTLX10dr
	 KiBQQw515LGcG4zUgb5lFb0sSWYR79p3qfj90yPFj09SZVKQgjS//j2tBN3vpHRExR
	 ePVB0gAgTO/tg==
From: SeongJae Park <sj@kernel.org>
To: Vinicius Petrucci <vpetrucci@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Issue while testing new fvaddr feature
Date: Thu, 20 Oct 2022 00:43:44 +0000
Message-Id: <20221020004344.99662-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEZ6=UN4jagT49VHPr4oM0BSqUOybFyty85hrWKeKAq0QApSXA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Vinicius,

On Wed, 19 Oct 2022 18:58:15 -0500 Vinicius Petrucci <vpetrucci@gmail.com> wrote:

> Hi SeongJae!
> 
> I appreciate your feedback on this. Your explanation makes sense and I
> didn't notice the "commit" feature. Sorry!

No problem, I'm glad to be able to help you.

BTW, we usually reply to emails in interleaved style[1].  It would be better if
you could also use the style from next time.

[1] https://en.wikipedia.org/wiki/Posting_style

> 
> Nevertheless, I am still not able to get any perf data, and now I am
> getting some errors. Not sure what I am doing wrong now. I tried both
> approaches.
> 
> 1) I tried doing “on” only after setting the start/end address, and got:
> 
> # echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state
> 
> -bash: echo: write error: Invalid argument

I modified your script in the way and I was able to reproduce your issue.  I
also got below great debugging-important information thanks to your script:

    $ sudo bash test.sh
    140437117468672 140438191214591
    140436041629696 140438191214591
    test.sh: line 40: echo: write error: Invalid argument
    $

So, that means the script was trying to 140437117468672-140438191214591 of the
masim's virtual address space range as the first monitoring region, and
140436041629696-140438191214591 of the range as the second monitoring region.

As you can show, the two ranges are overlapping.  DAMON sysfs interface assumes
the regions will not overlap, and in order.  That is, your script enters
invalid regions, and therefore DAMON returns the error.  I admit that the
documentation is not kindly explanining this, sorry.  I will try to elaborate
the document later.

To show if this is the case, I slightly modified your test script to monitor
only the first region as below.

    diff --git a/test.sh b/test.sh
    index c4e0145feebe..b2869eefc25e 100644
    --- a/test.sh
    +++ b/test.sh
    @@ -18,25 +18,18 @@ start2=`cat strace.out | tail -2 | tail -1 | cut -f2 -d=`
    
     # convert to decimal
     start1=$((${start1}))
    -start2=$((${start2}))
    
     size1=`cat strace.out | tail -2 | cut -d, -f2 | head -1`
    -size2=`cat strace.out | tail -2 | cut -d, -f2 | tail -1`
    
     end1=$(($start1+$size1-1))
    -end2=$(($start1+$size1-1))
    
     echo $start1 $end1
    -echo $start2 $end2
    
    -echo 2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions
    +echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions
    
     echo $start1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start
     echo $end1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end
    
    -echo $start2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start
    -echo $end2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end
    -
     echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state
    
     perf record -e damon:damon_aggregated &


After this change, 'perf script' shows some data.

    $ sudo perf script | head -n 15
           kdamond.0 99584 [008] 30042.929871: damon:damon_aggregated: target_id=0 nr_regions=4 139805163782144-139805292630016: 1 0
           kdamond.0 99584 [008] 30042.929876: damon:damon_aggregated: target_id=0 nr_regions=4 139805292630016-139805378531328: 1 0
           kdamond.0 99584 [008] 30042.929877: damon:damon_aggregated: target_id=0 nr_regions=4 139805378531328-139805722128384: 1 0
           kdamond.0 99584 [008] 30042.929877: damon:damon_aggregated: target_id=0 nr_regions=4 139805722128384-139806237528064: 1 0
           kdamond.0 99584 [008] 30043.036517: damon:damon_aggregated: target_id=0 nr_regions=7 139805163782144-139805202436096: 0 0
           kdamond.0 99584 [008] 30043.036520: damon:damon_aggregated: target_id=0 nr_regions=7 139805202436096-139805301219328: 0 0
           kdamond.0 99584 [008] 30043.036521: damon:damon_aggregated: target_id=0 nr_regions=7 139805301219328-139805378531328: 0 0
           kdamond.0 99584 [008] 30043.036522: damon:damon_aggregated: target_id=0 nr_regions=7 139805378531328-139805447249920: 0 0
           kdamond.0 99584 [008] 30043.036522: damon:damon_aggregated: target_id=0 nr_regions=7 139805447249920-139805722128384: 0 0
           kdamond.0 99584 [008] 30043.036523: damon:damon_aggregated: target_id=0 nr_regions=7 139805722128384-139806082908160: 1 1
           kdamond.0 99584 [008] 30043.036524: damon:damon_aggregated: target_id=0 nr_regions=7 139806082908160-139806237528064: 0 0
           kdamond.0 99584 [008] 30043.138314: damon:damon_aggregated: target_id=0 nr_regions=11 139805163782144-139805202436096: 1 0
           kdamond.0 99584 [008] 30043.138317: damon:damon_aggregated: target_id=0 nr_regions=11 139805202436096-139805281460224: 1 0
           kdamond.0 99584 [008] 30043.138318: damon:damon_aggregated: target_id=0 nr_regions=11 139805281460224-139805301219328: 0 1
           kdamond.0 99584 [008] 30043.138319: damon:damon_aggregated: target_id=0 nr_regions=11 139805301219328-139805370798080: 1 0

> 
> 2) When doing “on” just after setting pid_target, then setting
> start/end addr regions (as originally), then added a new echo “commit”
> to the state variable, the kdamond automatically goes to “off” state
> and cannot be set to "on" anymore. As follows:
> 
> # echo commit > /sys/kernel/mm/damon/admin/kdamonds/0/state
> 
> # cat /sys/kernel/mm/damon/admin/kdamonds/0/state
> 
> off
> 
> # echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state
> 
> -bash: echo: write error: Invalid argument

When you write 'commit' to 'state' file, DAMON reads the region directories and
find that the input is invalid, so refuse to continue running.

DAMON does not reset the file inputs, though.  So when you write 'on' to
'state' file again, DAMON again reads the invalid region inputs and the
situation becomes same to the scenario 1 (set region first and write 'on').

> 
> Please let me know if you have any further directions on how to better
> understand/debug this.

Hope my answer explains the situation.  If there is anything I missed or wrong,
or if you have any more question, please feel free to let me know.

Again, thank you for your question.


Thanks,
SJ

> 
> THanks again!
