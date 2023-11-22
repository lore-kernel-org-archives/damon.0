Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0A21376
	for <damon@lists.linux.dev>; Wed, 22 Nov 2023 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXGUpf/O"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so78374061fa.0
        for <damon@lists.linux.dev>; Wed, 22 Nov 2023 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700644422; x=1701249222; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czz0nsZXAuzO0t2l90LkLuXKQKsXZcy5T0aEg09grO8=;
        b=pXGUpf/OvxTJAmz2zUDj7e0YDWfSgebtuhD/9Rk9+VX5hDpqq/qO+sTt+WnqFO5iKm
         4eCliX07u+1QAhvilO0KlcCQgBvENtHwFgYxY+aY94UakdiCocweDKVdOeJTeemwdm+/
         ts8oq+jmdo5eLROSnhLH8gKRh7R/dO5P5zeW2jJShLKQftWM+aDL1ozHKYGcLfrUgh7h
         mUzc4dIm1vsWbAeS2/NHc4yOyfP5lBIINhcL5jwLc7KM0pAOXL+vLGK10LFYyIKq1ZY1
         96pPDQ9I6fuasc0mHgKRDcnx+t6SZ1ChnmGTlkzU0IURjzS9ZyTlx4ZyWOPxTDgTedkt
         4gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700644422; x=1701249222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czz0nsZXAuzO0t2l90LkLuXKQKsXZcy5T0aEg09grO8=;
        b=jt6tTuRyOqI4Y5VP4k7Nclh/hewcAC8g+b8lGu+fRw5pXxlqJok7QOZkA4NjS52Qp6
         0p+s/JAzQutri65U1zlFUu1YZuTYVAG6o/7GXn+2uTLp6StllFLWXM2aLuIOBa/EKfay
         n9d0ocUYSSkgjIuUpbgL4jURe043BSqSZpA18sRxebVpmDJRGX63YmJ3rXhl+cdECTNJ
         1tY34tIqWwWunQ0jZZnUgdT1B4DuQQpl2iHiw7h2keKx5oMtg4emf0Z+dQh9giLq7wkG
         p3pkGolceixgA1Bsm9pFGqCspTtwHNcU9MsBAAzkKE16rwODcYKXMLPPYIBMWitbMKXT
         b0dA==
X-Gm-Message-State: AOJu0Yy68PPZx/7bcSybreE59KrpfyHAUm7bP94ixXVhAIkllMu6ApKD
	QeMJqHSz9i5x79UnDj63cm7xpw==
X-Google-Smtp-Source: AGHT+IGtrjMlWRjUgICA9jh1noy1De6jMjESZr78bJoGyz59ZE78MZYTI3HId5TPi+4kH9qPm0K+UA==
X-Received: by 2002:a05:651c:a0e:b0:2c8:71b4:f8b5 with SMTP id k14-20020a05651c0a0e00b002c871b4f8b5mr1394219ljq.48.1700644422503;
        Wed, 22 Nov 2023 01:13:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s3-20020a05600c384300b004077219aed5sm1551237wmr.6.2023.11.22.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:13:42 -0800 (PST)
Date: Wed, 22 Nov 2023 04:13:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: SeongJae Park <sj@kernel.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 32/42] mm/damon/core.c:1150
 damos_set_effective_quota() error: uninitialized symbol 'esz'.
Message-ID: <aa9343f1-b0f9-4452-82e9-d63192ecbcd7@suswa.mountain>
References: <473b4c2e-863d-42ec-860a-bf8ec4385240@suswa.mountain>
 <20231121173602.62313-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121173602.62313-1-sj@kernel.org>

On Tue, Nov 21, 2023 at 05:36:02PM +0000, SeongJae Park wrote:
> Hi Dan,
> 
> On Tue, 21 Nov 2023 02:37:12 -0500 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> > head:   54ffd8ae08121d8cbce1874fe46970cce643a2c7
> > commit: 28cef0e565adbb4175f12ffffce9d0680979de60 [32/42] mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning
> > config: x86_64-randconfig-161-20231121 (https://download.01.org/0day-ci/archive/20231121/202311210420.URG3QSAS-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231121/202311210420.URG3QSAS-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Closes: https://lore.kernel.org/r/202311210420.URG3QSAS-lkp@intel.com/
> > 
> > smatch warnings:
> > mm/damon/core.c:1150 damos_set_effective_quota() error: uninitialized symbol 'esz'.
> 
> Thank you for this nice report!
> 
> However, damos_set_effective_quota() is called from damos_adjust_quota(), which
> ensures at least one among quota->{ms,sz,get_score} is nonzero.  And
> damos_set_effective_quota() ensures quota->{ms,get_score} is non-zero at the
> beginning of the function.  Then the function sets esz anyway, for non-zero
> quota->ms and quota->get_score.

The problem is in the "non-zero quota->ms" situation.  It uses an
uninitialized value of esz to initialize esz.

28cef0e565adbb SeongJae Park 2023-10-27 @1150           esz = min(throughput * quota->ms, esz);
                                                        ^^^                               ^^^
This is the uninitialized variable.

regards,
dan carpenter


