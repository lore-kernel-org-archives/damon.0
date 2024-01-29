Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A635FEEF
	for <damon@lists.linux.dev>; Mon, 29 Jan 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530405; cv=none; b=bSa5gWRueYbRgY7RLDLO1QThQdKjZxA8HBhku78mUqQgpP3aZXiiFVt9AEjB9tf0rN65GywNeOBmvv2tL+k4Cm/RzZEUARL1EsFpALkKkQ5uXceJ/7WGQ2JMLEQX6jGY+2/nDIkHEcidSTzsqqsD8eX5lMeiolZc8gmI96acl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530405; c=relaxed/simple;
	bh=WLvrHrbgSBFuvT4E7HlrAAw1sNsWn7JBXxbApEH6mhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REA3vx9KqQnRxCUlh4dyrfbEZvVguvBDXHpMdsfukbumbAPw90ZgSS2Vev8i0bmhXzqigOZcyaruEHb+nogiGMBmAwY4mnCeTMtcSwSwKP8lkrtgjPLCWNx6MSSzPx+4GDMrYSKKHDeGNaACU1WMC/RPex5gwXyQi5jmbsD4f7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1buU2Jk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1buU2Jk"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d748d43186so11839545ad.0
        for <damon@lists.linux.dev>; Mon, 29 Jan 2024 04:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706530403; x=1707135203; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoaRRVJZbpwuRBmsx74Q+sew1YTbfPVtekdObdLjHlE=;
        b=l1buU2JkMokPIOKViGVyptiInYqigSCYJWxvkIrbDmZB91qfabA+mHAWOCDobjs8Fr
         VqGGj8U/EDzEsGvACcS+myse7XRu6GtX+hI+fcpUOxI2/P5E2u0KDLu27Ueo/A6msK/0
         zy+1rl6e+iWOXc36MeImfuku9zAMOWytNFfDuGjYdxg6VkD9cLX/P4kK0mq+1RR7kJg7
         VTH1l2sIlEoMoS1FH8sTYCE3X33C2U1rv4ff493IXlRmfyZTlf99TeSzRAgGTWsix2N8
         FXGkYcnijd7p9qr4dbJW52UyDnTMDwqpLJSQyPaF4WZkqnbd7IUlHM0nyORNEyStq7xA
         RspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706530403; x=1707135203;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoaRRVJZbpwuRBmsx74Q+sew1YTbfPVtekdObdLjHlE=;
        b=fhJ/Pg+DRTRqb1xDorbgPh/pvB5cL9jyoU+ImbdBmQHBrbQtseIz1WHirOhfv/G79z
         0f1jBoKt4VaInG65caM3FuKE2LxS7PF3gwMkeGmGE6C2UbO91SoQrai7YW6vSjee6Sis
         2NP3pCeD+s282b90vXrWxrp8KftJbrGUz/VvUdBqeWhPuEGAAhIugj0gcOVgh5RXUAmT
         McNhg9NRLXD74YlLD41carnqItWYAvqAStpg8L4px1k4WIwBePW8D1ob3Ayf2niM4PoU
         cFHCrmqewHJyWcZg8y9NmJvivRBo8Dycn0BQPymlXmyxSLfLqAG743dzmfsbtpkH13Jg
         fwsA==
X-Gm-Message-State: AOJu0YwiQU55SAfY79KhKXckylpCfQoQ6UoOVue/cQgebkKNvv4juW5c
	tirbO1MLERGWJNBhCIuz5rBSOov0EZFxKf3ZDYhZiX0PcQ9xKxLq
X-Google-Smtp-Source: AGHT+IGe75wXRfHfhKAZFoV1YLgi2pirWtWkd84BfMTXVJ46oMR/sFEsWExHX0KeLGpQuF/FiHFUMA==
X-Received: by 2002:a17:902:6804:b0:1d4:e04b:4742 with SMTP id h4-20020a170902680400b001d4e04b4742mr2117030plk.58.1706530403008;
        Mon, 29 Jan 2024 04:13:23 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001d714a1530bsm5242067plg.176.2024.01.29.04.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jan 2024 04:13:22 -0800 (PST)
Date: Mon, 29 Jan 2024 20:13:16 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20240129121316.GA9706@cuiyangpei>
References: <ZbYanPU16klwz0HA@cyp-ubuntu>
 <20240128162804.17866-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128162804.17866-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Jan 28, 2024 at 08:28:04AM -0800, SeongJae Park wrote:
> On Sun, 28 Jan 2024 17:13:00 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Fri, Jan 26, 2024 at 12:04:54AM -0800, SeongJae Park wrote:
> [...]
> > > So, 'update_schemes_tried_regions' command is firstly handled by
> > > 'damon_sysfs_cmd_request_callback()', which is registered as
> > > after_wmarks_check() and after_aggregation() callback.  Hence
> > > 'update_schemes_tried_regions' command is still effectively working in
> > > aggregation interval granularity.  I think this is what you found, right?
> > > 
> > Yes.
> > > If I'm not wrongly understanding your point, I think the concern is valid.  I
> > > think we should make it works in sampling interval granularity.  I will try to
> > > make so.  Would that work for your use case?
> > > 
> > It's much better than working in aggregation interval.
> 
> Thank you for confirming.  I will start working on this.
> 

Great, looking forward to seeing the progress.

> > 
> > I have a question. Why does the 'update_schemes_tried_regions' command need to work
> > in the sampling time or aggregation time? 'update_schemes_tried_regions' is a
> > relatively special state that updates the regions that corresponding operation scheme.
> > Can it be separated from other states and controlled by sysfs node to respond immediately
> > after being written?
> 
> Mainly because the region data is updated by a kdamond thread.  To safely
> access the region, the accessor should do some kind of synchronization with the
> kdamond thread.  To minimize such synchronization overhead, DAMON let the API
> users (kernel components) to register callbacks which kdamond invokes under
> specific events including 'after_sampling' or 'after_aggregate'.  Because the
> callback is executed in the kdamond thread, callbacks can safely access the
> data without additional synchronization.  DAMON sysfs interface is using the
> callback mechanism, and hence need to work in the sampling or aggregation
> times.
> 
Thank you for the detailed explanation.

> Thanks,
> SJ
> 
> [...]
