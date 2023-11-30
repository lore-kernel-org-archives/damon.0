Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB59200B9
	for <damon@lists.linux.dev>; Thu, 30 Nov 2023 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfPKmef6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cf856663a4so6589485ad.3
        for <damon@lists.linux.dev>; Thu, 30 Nov 2023 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701335672; x=1701940472; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkZm04lfRlD3mzOUGiHtFxV8qZ1vw4L1VTf3erF9dac=;
        b=JfPKmef6BVDJlvXA6aGa5Zp6TarAGB3UfW+YmJZOUksj66+3vGv/Jfros78Wt92Uyz
         VD1KK8Nr/Qk500DNKqQwItAuKrMGVuiNHEL1iHblOWb1StfN36p1joHJTvPpUJsU+6EJ
         UFHWri4gJYVajaX8blpXxD+8x/Dt4zbBddr9YIcWivAR2vMD384s9XaSmod8tmUWnC9h
         hZ1jVSdxpq+y9s8maleTrFuqiTOccKmMURjyj6LN6XO7DpJYisVD3hG7jPj3T44y+zhx
         Uc0F0nVjZoLSI+QHUZr2HWfBWfwSpeXtlaKwU3KvVxxqu6UK199hmJ3IvXfi6QoCSH9z
         u4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335672; x=1701940472;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkZm04lfRlD3mzOUGiHtFxV8qZ1vw4L1VTf3erF9dac=;
        b=ilTAyLi/6T2c/ZlC8J/6MxuvMWrIduUNAs2tCWIDnknyZ/cpO3vwxRNZ/2kQsgTg2I
         dFk7jNVPv5MEiAFcYZ/nfcfxOOW7TPFKgWIdHKGqGdwR0oT81RWANd1kKPyGnyhirSpe
         4Zxws/5ORh1AcitY7TKUlRtqi0hINq8cszUb3gaWiOSYlmB25kJ4LH7U1ahoUhcor8B0
         /STtXT/W4q/aVkdWF3CKZv0A5TfBIpwZ9M3L0zZpFF/ouiOf6AO1nNnOE1qaWmOAQ/9+
         BmQTC4TzDJmvT6lF31Opxuqe40MWdpFmfConCDJcMPhbHUPeEv4tBdFvQvRAhQ/+MI8e
         dENQ==
X-Gm-Message-State: AOJu0Yx8KH2tG+EhAmOX+L2DwAFG7vVO2yh3lbUU9369Fmzs6T9CblUi
	piu5XEZ03gf5xcSXBRCE52I=
X-Google-Smtp-Source: AGHT+IFcncNN/ZTUn02k8CmbBs5KH3TQJCqee4HEtCviqsR8oz+yW8pmspfox950SyTatF7XsUr+2g==
X-Received: by 2002:a17:902:db09:b0:1cf:cc0d:b269 with SMTP id m9-20020a170902db0900b001cfcc0db269mr15176117plx.40.1701335672265;
        Thu, 30 Nov 2023 01:14:32 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902700400b001cfc46baa40sm835498plk.158.2023.11.30.01.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2023 01:14:31 -0800 (PST)
Date: Thu, 30 Nov 2023 17:14:26 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231130091426.GA13946@cuiyangpei>
References: <20231129131315.GB12957@cuiyangpei>
 <20231129171058.50270-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129171058.50270-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

Hi SeongJae,

We also investigated the operation schemes you mentioned, but we don't
think it can fit our needs.

On android, user will open many apps and switch between these apps as
needs. We hope to monitor apps' memory access only when they are on
foreground and record the memory access pattern when they are switched
to the background. 

When avaliable memory reaches a threshold, we will use these access
patterns with some strategies to recognize those memory that will have
little impact on user experience and to reclaim them proactively.  

I'm not sure I have clarified it clearly, if you still have questions
on this, please let us know.

Thanks.

On Wed, Nov 29, 2023 at 05:10:58PM +0000, SeongJae Park wrote:
> Hi Cuiyangpei,
> 
> On Wed, 29 Nov 2023 21:13:15 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > Hi SeongJae,
> > 
> > We are using damon on the Android operating system. It starts monitoring
> > when app comes to the foreground, stops monitoring and save the
> > monitoring results when app goes to the background.
> 
> Thank you so much for sharing this detailed use case.  This will be very
> helpful for us at understanding real usage of DAMON and making it better for
> that together.
> 
> > 
> > The two methods that you mentioned,
> > 
> > 1.tracepoint events
> > This method requires opening the tracepoint event and using the
> > 'perf-record' tool to generate the perf.data file. Then parsing the
> > perf.data file. However, the user's phone is not enabled tracepoint
> > events. Additionally, the generated file is quite complex, and we only
> > need memory addresses and access frequency informations.
> 
> That's fair points, thank you for kindly explaining this.
> 
> > 
> > 2. damos
> > There is no direct Python runtime environment on android phones.
> > 
> > Both of these methods provide results that are not very intuitive and
> > require complex parsing. We save the results in the format of starting
> > address, region size, and access frequency. When the available memory
> > reaches a threshold, the user space reclaim memory with low access
> > frequency by calling 'process_madvise' function.
> 
> Again, very fair points.  So, if I understood correctly, you want to reclaim
> cold pages proactively when the available memory reaches a threshold, right?
> DAMON could do that directly instead of you[1].  Using that, you don't need to
> save the access pattern and parse but just ask DAMON to find memory regions of
> specific access frequency range and reclaim.  Have you also considered using
> that but found some problems?
> 
> I understand the feature may not perfectly fit for your use case, and I want to
> learn from you how it could be better.
> 
> [1] https://docs.kernel.org/mm/damon/design.html#operation-schemes
> 
> 
> Thanks,
> SJ
> 
> > 
> > Thanks.
> > 
> [...]
