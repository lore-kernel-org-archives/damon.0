Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0E2136C
	for <damon@lists.linux.dev>; Fri,  1 Dec 2023 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIE66rid"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d0521554ddso3881175ad.2
        for <damon@lists.linux.dev>; Fri, 01 Dec 2023 04:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701433513; x=1702038313; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFLb7KVsw6jFSNkRuQETVY19rXhRyG8eEk4pj82LTQI=;
        b=DIE66ridrpAUZJy1Vr4TDpKiTCafsTIKF+T5LoE0S9ngxD/KRdqqTFKW5TnYh1e9ym
         0HsdEtxxlaDeCZQYS6TwLX/pbdQ6bn/zjdEwJDNE/VDq8USgOsGTsY3ovVvmPSLNPid7
         K4odC0Omd2VJNcr6feP3QDdDFojilqvUjw/eB6ANw/GC0Ij57ojrUp3wUFV2buumeHrn
         6CsXsElbxeDbaE16cNXChRlV5v10czhKWN09zKxrz2GqFn+LDSPtVx5hQHcf+0sZ5zMN
         IKF4Eth3/uqalhPOGN6hjwuOG1bjRYwiuBe1SDl04d+ZSE+8UOvh/3OF8SLaXfzlcB1b
         nwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433513; x=1702038313;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFLb7KVsw6jFSNkRuQETVY19rXhRyG8eEk4pj82LTQI=;
        b=PR2UWgt9KJrrPsY5JaIn/UNhgyqVT44TnMocU8qGdWKYbjzydhOt5k/Ari46CxYmls
         oE9hBo7TyXU62Bb7Zm6PCqXHKI0FrfUCaIYgbCMzZjNoR3Wrx/bMiK6jq03Tnstippb0
         GGVgCcj0re+Sdt6QlOfN6ZITZyTaGqwR7t/k4Y7UpQwI5ZQ8Y3Yv3HM+S7I8fPptcMXS
         8sPca2fQZUR10n3ItpCEK/GFuqpT/Rqh9coG4qVzDVUwZwwiuzKXNLIEzCqUj7btGx2x
         VPm/B0+V7/FHqLvdY28pcp4daZLHlwigWMkUV7T7X6ua4A8yx2GsAlT5g5vFgWTr5bdW
         /z+g==
X-Gm-Message-State: AOJu0YzBuQEj/wM7rHwqF3pAfElAWFSmSJXB/+9TYisA1TmxY7RZ+Bbs
	HWBNR4xssfRwme4s8gKMs4w=
X-Google-Smtp-Source: AGHT+IGwHjW8ph1E++zlfVk58m5vvGNHyejPxcXVReGB+FDfMZvDbQ7ctLqTN3OYTS2OGZHVQSIrgA==
X-Received: by 2002:a17:903:445:b0:1d0:5db3:7791 with SMTP id iw5-20020a170903044500b001d05db37791mr661485plb.63.1701433512659;
        Fri, 01 Dec 2023 04:25:12 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001cfacc54674sm3250857pln.106.2023.12.01.04.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Dec 2023 04:25:12 -0800 (PST)
Date: Fri, 1 Dec 2023 20:25:07 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231201122507.GA15806@cuiyangpei>
References: <20231130091426.GA13946@cuiyangpei>
 <20231130194420.51355-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130194420.51355-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> Hi Cuiyangpei,
> 
> On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > Hi SeongJae,
> > 
> > We also investigated the operation schemes you mentioned, but we don't
> > think it can fit our needs.
> > 
> > On android, user will open many apps and switch between these apps as
> > needs. We hope to monitor apps' memory access only when they are on
> > foreground and record the memory access pattern when they are switched
> > to the background. 
> > 
> > When avaliable memory reaches a threshold, we will use these access
> > patterns with some strategies to recognize those memory that will have
> > little impact on user experience and to reclaim them proactively.  
> > 
> > I'm not sure I have clarified it clearly, if you still have questions
> > on this, please let us know.
> 
> So, to my understanding, you expect applications may keep similar access
> pattern when they are in foreground, but have a different, less aggressive
> access pattern in background, and therefore reclaim memory based on the
> foreground-access pattern, right?
>

Different apps may have different access pattern. On android, the apps will
join in freeze cgroup and be frozen after switch to the background. So we 
monitor apps' memory access only when they are in foreground.
> Very interesting idea, thank you for sharing!
> 
> Then, yes, I agree current DAMOS might not that helpful for the situation, and
> this record feature could be useful for your case.
> 
> That said, do you really need full recording of the monitoring results?  If
> not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
> monitoring results snapshot that include both frequency and recency of all
> regions in an efficient way.  If single snapshot is not having enough
> information for you, you could collect multiple snapshots.
> 
> You mentioned absence of Python on Android as a blocker of DAMOS use on the
> previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
> or Python.
> 
> Of course, I think you might already surveyed it but found some problems.
> Could you please share that in detail if so?
> 
DAMOS tried regions feature you mentioned is not fully applicable. It needs to
apply schemes on regions. There is no available scheme we can use for our use
case. What we need is to return regions with access frequency and recency to
userspace for later use.
> [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
> [2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/
> 
> 
> Thanks,
> SJ
> 
> > 
> > Thanks.
