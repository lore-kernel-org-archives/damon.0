Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883D73E51F5
	for <damon@lists.linux.dev>; Tue,  5 May 2026 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967161; cv=none; b=mGpvMsB2h/DW7ownKRJOs7vzmd84SMFg37spckE6GUTMaY6bPd9dCto05Z6j3B28ykNFvmebftTR90vCNiAGsjdSlv0WpKPIFm7pouf5zMi2CzltzBCoI3wFrxbYqOE8HZQvhqCjGpIoJ5iM3Ak7l/ILKT5/j0UDxWPtHPf0apI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967161; c=relaxed/simple;
	bh=nHnlIoIYgby//JTQJ23HCL1ahPlq53pZkc5FnZs96GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1MW33Rb7HhD22V8jUFYDQbzVV+amayfTSuox0xLHkDlxP/MHs3ISQ0076UpZ3vS3PBHlEAuNNKMw/K7z8Vz+/L+uBtE+vxoutD9IvxZz3v4FPFl5rH9rziylobzZG+L5zS5RWYoAUqMd2HPmae5MDvQdmKAU7t0WUvgK4jXaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oY4yRT0d; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oY4yRT0d"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so2729572f8f.0
        for <damon@lists.linux.dev>; Tue, 05 May 2026 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777967152; x=1778571952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=oY4yRT0dBzZU+D0MeRaYvnZZe6hf5oSSH8DJKdk0Fb9kaJ/ZWUdBBc+G6H4RHD4Ig7
         zwUMzhZpncGwt8Rb5zlMOerDZodzcoP3+CjLplIg3w3W6aJcdsTQ5QPa8xd7qb8RpHYh
         1Wl0HGZV2t5v2cIIZfaYbQRXAX1PnzqBC3o2dezcN8BbXU7sjwbZfngaDuydZ5G/7i+5
         D9gJBhJTbT404pPyhTyGffdRo3SDvkze5DCzSujAZZF9Jft1qpbJc/LRZForpeIIWrQl
         HEdLBM3SaEpp9QtQLlMlqbQjmwfi88U8tIPXm8RwqAeNyjSh4LMx+E0qwYYhTnIB+jOt
         Yu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967152; x=1778571952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=hK6sbnXEMvT4oLJJAweFTex2naIYyU8pOGvY1u3oqeG9A1o6sszFKx0tGmcNf0oMsX
         z9TATa8tP7BG+Wb386zPaivXf6ydB5pDQNMLFhD+QeZQQ3aVMAx0ibUMBHglIghtAgO4
         BuOaREuOGbPbK/y/B2vh7Vknd3pHQMjJOWMAdLax8e6T9y/IWNgArEoPs2lNAc5qwqDI
         uJ3GexbqpjmduLjf7u30Ht1xkyV2de/vLKv1uD0FHho4wV3FXXVchZN2BvktG5uxXHo+
         faUz2MSKgv6SDkzbZ2ydwreQjRpDDB7ylddSS1t2P4iFdb3mEshmoaHNPAc5TNzVw8kA
         aZxw==
X-Forwarded-Encrypted: i=1; AFNElJ/FNduYQmABdE913DDsDH4vEQ/NTBP1/MMRTPmukmWx7wVm0YkvNe1olIw/T7tI1t/pboxhRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrcGpLDOyWWf/qt0rNUJyA8SSYDh+B2jVh/BnAWjXgN0uCFRZ2
	NJXDw91kdZ0OccVZ+CqzXtuGxmrzVNPv2rCqLzavToUVhchOAjw6KYjmkXhtfOtIxQg=
X-Gm-Gg: AeBDietMPV23NLuY8lv/eXI64TI3jZjbW3pJAAI3kuuA2HKmsmqgtq8MvYsdaWcObu7
	n18yTWD8UKnsscnwRm5O/vxVTYCpLkCmHg2RmZuR6VQouNt2jN7nByvTiDTeKGNMiTtiF8AncX8
	EJbX11sC2lTuOKfvL2ypL7l8e/boaQu6qm3A1igAgaoLiz4nVtkCp0LWmyyjfx7nCND26A0YgPs
	pVqbmgGNc5xwLso1RcEzyr+ugRpfsqs0pO9hqoFRSCTNypb2R15pQ0ZX7QTdgtAve5PeFZnK+0A
	xuWXKXUoluw/PMenxmlUt6G1+J+sqVBMx4gnyFgqM1P/msg7kBR9uD0R0jmAFm3b6uV1zgBz48t
	X0R218fDuQEAcrEjB0by8F4uYYp2jk0AZui8E5FZ+7qiYIQYEOrSqLjP5PC0LauJmbiJeua1kd4
	ex+V0dQAPmgQ6FzyLIMF2i/r3WvFUb7MFWVoOiBm3S5Wtb
X-Received: by 2002:a5d:5d87:0:b0:44a:2f78:e873 with SMTP id ffacd0b85a97d-450041b08d5mr3594275f8f.17.1777967152279;
        Tue, 05 May 2026 00:45:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm2455028f8f.32.2026.05.05.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:45:51 -0700 (PDT)
Date: Tue, 5 May 2026 08:45:41 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
 <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
 <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>

On Mon, May 04, 2026 at 06:38:54PM +0530, Arun George/Arun George wrote:
> On 29-04-2026 07:12 pm, Gregory Price wrote:
> 
> But I see this 'write budget' (budget in terms of number of write 
> operations that can be handled by the device, not capacity) to be 
> provided by the device in control plane; not by the workloads in the host.
> 

In the scenario i'm talking about, a "write budget" is defined as a
number of pages that are allows to be mapped writable in the page
tables at any given time.

>   1) We can modulate the write budget depending on the actual 
> compressibility in the device (and so workloads data). We don't have to 
> do estimation based on the workloads.
>

Barring the device causing backpressure to increase latency and slow
down writes, modulating a write budget doesn't actually do anything
useful.   Once a page is mapped writable - the CPU is free to write to
that page uncontended.

I think a write budget is "doable" but maybe a bit optimistic for an
MVP.  There are many corner cases to handle, and I would prefer to see
that as an experimental optimization.

>   2) We don't have to do the capacity modulation - as in ballooning or 
> shrinker.
>

You still need capacity modulation in some way to respond to drops in
compression ratio.

~Gregory
