Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A210E9
	for <damon@lists.linux.dev>; Sun,  3 Dec 2023 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyC0QhWF"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1faecf57bedso1457372fac.3
        for <damon@lists.linux.dev>; Sat, 02 Dec 2023 21:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701582198; x=1702186998; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulpex2/K0nFLvwaganrs1elk8GQQ5l+5GEHyn5YwooQ=;
        b=JyC0QhWFqdCdA+8OL3Md36RoJYITCx6SD3yOqP3YGQIyTAI2hH42L4stYPPBoEqYBr
         qkLwtfkLvrPj+bDFBvshmsJOUe+tW6oGCO+TL+PR+eG4CRIW/KvokdUJ6LJglWBeonhi
         5p+Q68/3EwS0jafyQ7tTGoaLSLRpDGhY7QYOgExOiLMcwUBT8L016bGDxls7O7iYrN5c
         UuxV9IKjv29ktL1GZnV2Sm/Q2zbHdmUyDrDR6TbnX8WngwDu/KPAX+uur5Jq1U95oHjc
         AbvsM+x9r1JrczEcxi+DAeBiCJGEOu8q8ts4wRuZ5AKKdaWvaSWQA/UkRYBye6aoiSnE
         xdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701582198; x=1702186998;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulpex2/K0nFLvwaganrs1elk8GQQ5l+5GEHyn5YwooQ=;
        b=R3UBptT8vDd0pR3Sx1GF/PSplcMmJMhlrVYjzgWOfPtoEN2r5RDzD/jtDuQxWQBtb5
         fGkJSp95WzC/9YNCldZXq7dncBXhmnXJ//TL5iP2XHujajuGzK0H8SLvmw+ZCGrKRlbC
         W07F4lcGkB0M7mUK9HK86Voo23cNwYQ3NYQAm01l/MKje9SyactLHRwI/LdOcdsuUsIx
         DYNkVwKcx9YUjgXnuvPTUYKf/GKG3Cytjj1lJ+syFBqVOpywR7/wqdedBUFafuO6Xl5+
         IUG8Aj/Eg0uYP5YYEvsisB4rte5ihAnLlycS11IADNVC/4ArjK1eGW63TMV8O5TjAQNN
         PNJw==
X-Gm-Message-State: AOJu0YxBMYzuRBCULQSemNAXwLwNi10lsI9J0jP8jVsVG4Xkluj9TgQ6
	wYfzrXCzJH0VzFjiU8c9Gcc=
X-Google-Smtp-Source: AGHT+IHw+PS2DOyoNngsHLoHfwVNHqBw9yoPg6sTyYXO+vualSGM3APgi04B0s49HgFnLD/jC6UXmg==
X-Received: by 2002:a05:6870:d24a:b0:1fb:22f4:c49d with SMTP id h10-20020a056870d24a00b001fb22f4c49dmr1342317oac.23.1701582198569;
        Sat, 02 Dec 2023 21:43:18 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id a1-20020a656041000000b005891f3af36asm4872025pgp.87.2023.12.02.21.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Dec 2023 21:43:18 -0800 (PST)
Date: Sun, 3 Dec 2023 13:43:13 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231203054313.GA14316@cuiyangpei>
References: <20231201122507.GA15806@cuiyangpei>
 <20231201173112.64300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201173112.64300-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> Hi Cuiyangpei,
> 
> On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > Hi Cuiyangpei,
> > > 
> > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > 
> > > > Hi SeongJae,
> > > > 
> > > > We also investigated the operation schemes you mentioned, but we don't
> > > > think it can fit our needs.
> > > > 
> > > > On android, user will open many apps and switch between these apps as
> > > > needs. We hope to monitor apps' memory access only when they are on
> > > > foreground and record the memory access pattern when they are switched
> > > > to the background. 
> > > > 
> > > > When avaliable memory reaches a threshold, we will use these access
> > > > patterns with some strategies to recognize those memory that will have
> > > > little impact on user experience and to reclaim them proactively.  
> > > > 
> > > > I'm not sure I have clarified it clearly, if you still have questions
> > > > on this, please let us know.
> > > 
> > > So, to my understanding, you expect applications may keep similar access
> > > pattern when they are in foreground, but have a different, less aggressive
> > > access pattern in background, and therefore reclaim memory based on the
> > > foreground-access pattern, right?
> > >
> > 
> > Different apps may have different access pattern. On android, the apps will
> > join in freeze cgroup and be frozen after switch to the background. So we 
> > monitor apps' memory access only when they are in foreground.
> 
> Thank you for this enlightening me :)
> 
> > > Very interesting idea, thank you for sharing!
> > > 
> > > Then, yes, I agree current DAMOS might not that helpful for the situation, and
> > > this record feature could be useful for your case.
> > > 
> > > That said, do you really need full recording of the monitoring results?  If
> > > not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
> > > monitoring results snapshot that include both frequency and recency of all
> > > regions in an efficient way.  If single snapshot is not having enough
> > > information for you, you could collect multiple snapshots.
> > > 
> > > You mentioned absence of Python on Android as a blocker of DAMOS use on the
> > > previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
> > > or Python.
> > > 
> > > Of course, I think you might already surveyed it but found some problems.
> > > Could you please share that in detail if so?
> > > 
> > DAMOS tried regions feature you mentioned is not fully applicable. It needs to
> > apply schemes on regions. There is no available scheme we can use for our use
> > case. What we need is to return regions with access frequency and recency to
> > userspace for later use.
> 
> 
> Thank you for the answer, I understand your concern.  One of the available
> DAMOS action is 'stat'[1], which does nothing but just count the statistic.
> Using DAMOS scheme for any access pattern with 'stat' action, you can extract
> the access pattern via DAMOS tried regions feature of DAMON sysfs interface,
> without making any unnecessary impact to the workload.
> 
> Quote from [2]:
> 
>     The expected usage of this directory is investigations of schemes' behaviors,
>     and query-like efficient data access monitoring results retrievals. For the
>     latter use case, in particular, users can set the action as stat and set the
>     access pattern as their interested pattern that they want to query.
> 
> For example, you could
> 
> # cd /sys/kernel/mm/damon/admin
> #
> # # populate directories
> # echo 1 > kdamonds/nr_kdamonds; echo 1 > kdamonds/0/contexts/nr_contexts;
> # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
> # cd kdamonds/0/contexts/0/schemes/0
> #
> # # set the access pattern for any case (max as 2**64 - 1), and action as stat
> # echo 0 > access_pattern/sz/min
> # echo 18446744073709551615 > access_pattern/sz/max
> # echo 0 > access_pattern/nr_accesses/min
> # echo 18446744073709551615 > access_pattern/nr_accesses/max
> # echo 0 > access_pattern/age/min
> # echo 18446744073709551615 > access_pattern/age/max
> # echo stat > action
> 
> And this is how DAMON user-space tool is getting the snapshot with 'damo show'
> command[3].
> 
> Could this be used for your case?  Please ask any question if you have :)
> 
> [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n
> [2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions,
> [3] https://github.com/awslabs/damo/blob/next/USAGE.md#damo-show

Thank you for your detailed response, it is very helpful to us. We will look into it
and contact you if we have any questions.

> 
> 
> Thanks,
> SJ
> 
> > > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
> > > [2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/
> > > 
> > > 
> > > Thanks,
> > > SJ
> > > 
> > > > 
> > > > Thanks.
