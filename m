Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F44C72
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 17:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6659AC433D6;
	Wed, 19 Oct 2022 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666201512;
	bh=+diI9SCISw3g1Kjy+B4WDOPHkmLS+1oSLSOHmA7sPzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuP6g512y0XJAYk6VJ0JeZH0hb+3pn6WyZ4ymnonK9Nm2GhhaVVQjXena/uZNAdkA
	 j6VbpdU9uvfhqHZ3NcfmAMZjd0JxAsiAUAyprQoOo3EUWK8akAagSJsviA3EHCdj5M
	 7u3yPvRxUz/qlK6LgI7uyazs1XkaF0eMSEsW0BxDOHZZhbeDwNBfUxgTyXK4DPLbhJ
	 nhX3zwZidU9aVZlmo1bSKtzghwE0Df/0BR/GRjGDEIzWpcC2DUtg1utwuz2bHZnIqW
	 fzDVUnoAyJJPyVRqk+kaubGa2zX7JhaTsTOkwjivGs3Ft2rheh005xISirr8JZhV8L
	 PQRdCNowkhRVA==
From: SeongJae Park <sj@kernel.org>
To: Vinicius Petrucci <vpetrucci@gmail.com>
Cc: damon@lists.linux.dev
Subject: Re: Issue while testing new fvaddr feature
Date: Wed, 19 Oct 2022 17:45:10 +0000
Message-Id: <20221019174510.85286-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEZ6=UNUcH2BvJj++OrT=XQLdkidU79wmCO=tantSOB36pPNTg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vinicius,

On Tue, 18 Oct 2022 21:49:22 -0500 Vinicius Petrucci <vpetrucci@gmail.com> wrote:

> Hello,
> 
> I am experimenting with the new fixed address (fvaddr) feature of
> DAMON to monitor memory regions originated from user-level mmap/malloc
> calls.
> I used "strace" to intercept the mmap calls and derive "start" and
> "end" attributes for monitoring using the "masim" program
> (https://github.com/sjp38/masim) as an example that creates two memory
> allocations and keeps accessing them for a long time.
> Then, I used "perf record" to get the data, but perf doesn't seem to
> be recording anything. Nothing is shown after issuing "perf script".
> 
> Could you please help me spot any mistakes with my tests (if any)
> using the Bash script below? Could also please let me know whether or
> not that is reproducible in your system?
> 
> I am using kernel 6.0.2 and I checked that "fvaddr" is supported via
> "damo features".
> All steps in the script below ("test-fvaddr-damon.sh") runs without
> any errors. It is just that nothing appears in the perf data.

Thank you for reaching out to us with this kind question!

> 
> -------- test-fvaddr-damon.sh --------------
> 
> strace -e mmap ./masim/masim hint_test_inf 2> strace.out &
> 
> 
> sleep 2
> 
> 
> echo 1 > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
> echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts
> 
> echo fvaddr > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operations
> 
> echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets
> 
> echo $(pidof masim) >
> /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target
> 
> echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state
> 
> 
> 
> start1=`cat strace.out | tail -2 | head -1 | cut -f2 -d=`
> 
> start2=`cat strace.out | tail -2 | tail -1 | cut -f2 -d=`
> 
> 
> 
> # convert to decimal
> 
> start1=$((${start1}))
> 
> start2=$((${start2}))
> 
> 
> 
> size1=`cat strace.out | tail -2 | cut -d, -f2 | head -1`
> 
> size2=`cat strace.out | tail -2 | cut -d, -f2 | tail -1`
> 
> 
> 
> end1=$(($start1+$size1-1))
> 
> end2=$(($start1+$size1-1))
> 
> 
> 
> echo $start1 $end1
> 
> echo $start2 $end2
> 
> 
> 
> echo 2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions
> 
> 
> 
> echo $start1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start
> 
> echo $end1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end
> 
> 
> 
> echo $start2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start
> 
> echo $end2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end
> 
> 
> 
> perf record -e damon:damon_aggregated &

kdamond doesn't read the values of the sysfs files after turned on by default.
You can force it to read the values again by writing a special keyword,
`commit`, to the `state` file of the kdamond[1].

Therefore, in this case, DAMON would run with no region, and hence it gets
nothing to report.  I think that should be why you show nothing from the `perf
script` command.

So, could you please set the start/end values before turning the kdamond on, or
write 'commit' to the 'state' file here, and check if it works?

If there is anything I missed or wrong, please let me know.


[1] https://www.kernel.org/doc/html/v6.0/admin-guide/mm/damon/usage.html#kdamonds-n


Thanks,
SJ

> 
> 
> 
> sleep 15
> 
> 
> 
> kill $(pidof perf)
> 
> 
> 
> echo off > /sys/kernel/mm/damon/admin/kdamonds/0/state
> 
> 
> 
> perf script
> 
> 
> 
> killall strace
> 
> ----------- hint_test_inf -------------
> 
> #regions
> 
> # name, length
> 
> a, 1073741824 # 1 GiB
> 
> b, 1073741824 # 1 GiB
> 
> 
> 
> # phase 1
> 
> # name of phase
> 
> phase 1
> 
> # time in ms
> 
> 9999999999999
> 
> # access patterns
> 
> # name of region, randomness, stride, probability
> 
> a, 0, 64, 99
> 
> b, 0, 64, 1
> 
> 
> 
> # phase 2
> 
> phase 2
> 
> # time in ms
> 
> 10000
> 
> # access patterns
> 
> # name of region, randomness, stride, probability
> 
> a, 0, 64, 1
> 
> b, 0, 64, 99
> 
> 
> Thank you!
