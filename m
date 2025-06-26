Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497F2F1FF9
	for <damon@lists.linux.dev>; Thu, 26 Jun 2025 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965213; cv=none; b=T+V3df2F29XDWcA8QtOFt4q91bRQIKKoHocSORejAFttzpXOGZKFCXS91+++mubfU9CJ7jSNh6MjUCX0WP6ec4oC++YXnXRClAKhm0DtiUzGxqYifBV1Z2RI+xGrjc070fpSgS4kuLxhstbCMC05HaUTmXC0XBC810fjyXLiAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965213; c=relaxed/simple;
	bh=crS18D6pYsOocKn9wnCJEpttlUYW7yRf1rDWWn4k8y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnRimG4cmW79IvJ0BFtIGCBlLpsggNLlU01E33kjVMiNepyA1AP8l5fVWbMYLqjllWrFserIc3f/EubEWrux9zhcTK4WgffSjkxNavysXtDyN81sb8FUardEJZbvYfFD+Nditg606j2osZwwofg91VxV5L/BerAieOmnfowfVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KLbDor8K; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KLbDor8K"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a5903bceffso18871581cf.3
        for <damon@lists.linux.dev>; Thu, 26 Jun 2025 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750965211; x=1751570011; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crS18D6pYsOocKn9wnCJEpttlUYW7yRf1rDWWn4k8y4=;
        b=KLbDor8K4OT4+6q9BpH6NUDCdUqUjkG/R1onpX4RU1XDGIZwmPZYPylN2EHy9PtlhC
         U29Kj80Ej17eFeDMw+HJ+P4lmsdkTujxu15TVsIPcMeVfx2IhY/2GdBn+bZSi4EcFFRk
         Pqi2daKESZSBjRIve8Lk4maOspOb2AmsI4F26KOTgwCmzl4QW/23KyDjQ5W5or/wbWLI
         QEmQn5PGLSyg7v/nfnlpAlRFo2ksFL8XpI2gzgfpKJH/lDVJwRLag1Op34GCheOJ2CcZ
         kgF5oFK29sc8uXVxMS4ky7wxfvNJvI/o0AJUf7JDg/FCbxUElEVoII3mxZ6Js7lbW8DH
         XoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750965211; x=1751570011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crS18D6pYsOocKn9wnCJEpttlUYW7yRf1rDWWn4k8y4=;
        b=TuvnpmFoBqAgumNY/cG6B3rplttQFhJaiT5oM0rCYjVyFhlKStfCjW01SkL76y9sAR
         +EV1BvUAbRUQ47Yv9oeiNtMKvVTpKG3GmDlVgNy8gIXGeKugxfbAUpobYFnIEqd6qDet
         ucjHpT+cJvVwqIYcx+Rrwxg7ceTh0SGUz4YHm1EB+OlogWz+HnB1QGFrwrXoEbK78JRW
         dTLlo0LFIANV9XD2GtX5htwMX+xpwSBaV+bxKBsLvBXUCRlIU4aMxNwJXTMnBQOMCufR
         lQDzrY4DITVYC4k8jYxsPFf/OALhkd4gX7r9reYR4sM4c8jC7ZeDoNzLWUlivxswz0yb
         Pf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXOtrAqFhDNnuP4vrgwunvLz3DybPhC3E8IDLR6McIZ/2tteZeMY0jWR9A/hLcIIJi89+oiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVJxovRPILSbQRVfCS0zwbvxasAjOmJaf0lbPnwJJjR8bVa4/R
	j5LV0U4WrI6biYti96Ajr4VxrDx6rPDkkRAIJwIi9cLRJKewW6B8AqnNZ3EoayokjpM=
X-Gm-Gg: ASbGncvr+PNdDdXbGmVSTR3EeC6pQDupS1aBmEWE42z9V3IRg8G+/ML6Acj7nS0YISs
	FcvIX3iZDs9MJ48lzHIy3238F7c6IY6Nv6gVDVEwmgdJTY6zXFMKLRzk73dfoIUE6L7RKseYe0y
	r40mNwlLgWfyuRZyLKYwk/feGUGnPyIjqWXfUyLoYXZRUw5o9dEqErQXfl5D7zCn/7ruJADKxDd
	Dl8ayi9jvgOG3LGgZnURiA9IyVf6MALK4Ax8gkfAJfTCNp0xGnQAtWiwsgwyGBEFvkQbBU2akS2
	s3TjFQUpi4tWgbBfoRQRElcjVWPPzC1FrctNIvvavXhXHARVJjTcwsJ2
X-Google-Smtp-Source: AGHT+IGqA8lQ1cH53ir6fw08KJC7djOdZp2RUrDz1Yj+H2mUSZskC/zuBgb4Amp65i1QQVTm8QBcdA==
X-Received: by 2002:a05:622a:88:b0:494:a23a:cadf with SMTP id d75a77b69052e-4a7fcac48fcmr11154871cf.32.1750965210868;
        Thu, 26 Jun 2025 12:13:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:7aa])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc13976bsm2792161cf.18.2025.06.26.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:13:29 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:13:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bijantabatab@micron.com, venkataravis@micron.com,
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in
 migrate_{hot,cold} actions
Message-ID: <aF2b160mlNozbP4o@gourry-fedora-PF4VCD3F>
References: <20250620180458.5041-1-bijan311@gmail.com>
 <20250620202155.98021-1-sj@kernel.org>
 <aFmq5Y1zKov9__zh@gourry-fedora-PF4VCD3F>
 <CAMvvPS5ievG9Q2w1GEA5BH2mAX-XUR_=oo3AWMnDeUvyRF8jyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMvvPS5ievG9Q2w1GEA5BH2mAX-XUR_=oo3AWMnDeUvyRF8jyg@mail.gmail.com>

On Mon, Jun 23, 2025 at 06:21:20PM -0500, Bijan Tabatabai wrote:
> I'm not convinced this is true. If you have a workload that can
> saturate the local bandwidth but not the remote bandwidth, wouldn't
> you want the interleave weights to be more biased towards local memory
> than you would for a workload that can saturate both the local and
> remote bandwidth?
>

That sounds like an argument for task/process/cgroup-local weights, as
opposed to an argument to twiddle global weights.

These things need not solve all problems for everyone.

~Gregory
