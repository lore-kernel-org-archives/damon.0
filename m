Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A53A9628
	for <damon@lists.linux.dev>; Tue, 24 Feb 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952098; cv=none; b=B82Viq3gsA05HyUolbq8XrVQYm9tzjawMQymtefW1QgiD9nEEJjamOWs8ajr9HPMEVsqzUlSsxGPi8HfvXncTSpF6Ip3DA13wU1HVjSEH6inLkJhVHuzX4ADQJ0lYdh+AZBCe7hZqFkkOyULERjQOWl2wQ/yiib0HfZdACtZZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952098; c=relaxed/simple;
	bh=jdCxOTtyEPr/iR2B4h4Aq7P1P0AhdAHaD1MtdqqOD6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI6b0sEKqegYcRfHmpItLe0h5P95tXFzJMwoNBkyyat2IUV2k69/QBp0WEzAhqvg0zUXSyTElALLDn/uGFfiNsJ3EZpxebk+VYETfA0ew53tQvQ+w13QBvQyIIs1SC6cP6L3SKtFPQrtOBNlm/xOWmet8/rd5SbjJlS6c88n26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gIu4eXFf; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gIu4eXFf"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896fcfc591eso53986256d6.2
        for <damon@lists.linux.dev>; Tue, 24 Feb 2026 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771952096; x=1772556896; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u4GoWFznFuQrqLlGOUj7jRuDM2CBLv4iVo/JzLKZig=;
        b=gIu4eXFf7mnGzvIB+IHhsSHg6hFq0DVfTwP7o7ETlouHWzQCAl4GrporVNwr3qjFIp
         1byqxfGuk4YN7keDx2trKp03oOXxNJ7Hh0/Ef/5BLmNSuzJR6SUFiG/e9oLyk204GAr/
         fs/Gtco1ZbiWJYYjVS+IjbeeaDWXX0wrme3KdPd9+11ByRV5fqC9OCotjugJNivvrK2a
         lwoMjMzs2oWYUUZDYskW4Iga3nybVw/fNMGG15sCklUtJcOKcDXZM0RtRbZgmXVqasGO
         Poc9hyb+u6OD/53ZVxbreZUF6j/NuKfH5fXTWa2CHLGrp0i++cw9eFAzey5X8EdUOxKK
         5saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952096; x=1772556896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u4GoWFznFuQrqLlGOUj7jRuDM2CBLv4iVo/JzLKZig=;
        b=bPU21Kv7mhATVbvw1HiXu7c463Z7BHKdvNOTdoBFnxLJRXGF3DJaD+2tbTkqRkbgmb
         RSvu5ojUHucpYo868e9T5BWpoIJTcksFuXn16oq+DNFJlaw1pp7lr/T23Kqw0iPRo00y
         x6CSGB9sDPUmFcCrDfheQhfARMEZL7Z0gre++zmPppywqBvxiTgI1oi/X8jXKAb4c8Hc
         ISc8ZO4u6aIcWBj3zBdp/6Hk4d95ePrhFIcxx0/qkUnEvsWU/Ronpcf3ewOQtL7UXwo4
         SjVfoRRfYIjBoUwAbROOW7fd5jh43NWXLv9o8vne8YrO5oHJYG9H2XRm7mLGVHzh1qsI
         a42g==
X-Forwarded-Encrypted: i=1; AJvYcCXjWHmsBaGxDNujqHOEQL9AMUmE4f/Pmsn05RHf4hD2pXc9NcNZczh9WkWsEMfLBNYZVPtttA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4hvXCeqpYwja4J83ZgUmcNnj8bEQY9VDpM+nZLlrLCengWRo7
	tgPc4Fdjkps7H3eT//yCD0K37IHPFTA/rp3ULeZWnzqEA0AXfwdCanvAWhWZQ8/KiMk=
X-Gm-Gg: ATEYQzzXig1As77fpD6XeURvoLJZGXU/EiKiVcU/x7HHffLPFoAtMmwxctaY5+hCbDj
	broS2hpruMoQ3GZWs8kF3/NJUWYprHtgO4NEmz7oUf7aRf9V+CmFFoBPPKK/FOduYakqaocW2Gd
	+eG3IEkRfjx4YbK4oYu1ZXFCH8kMtf0oh/2Wow517g3CXf+0wOOAoQugDWorjmMpkthwrPEVzvs
	zS7UTMWQ33DryQckoo9n/BSAk0kvRC7YEfkcFp2UY4STX/RExRZq5bDGE5yle7Z8DRHl1/R6hw4
	tCGqFIGgeb4Y7v5nwd7mutZDe8RZzVWFVyE7MNAM3CLuPa+Wl6N1bAr+Wxf/F5dab1D76W7sOqq
	FDmbC70IWAdsA85MF846KJy2dpAb9ffX9wpHvixhDKwYErR21CFAHg32qUzcrSQlKSGXNJkGj09
	xhfs3c6a3YTOcwwDGKroCZ2xlpI03zkOjSFx6h4tmd8MiR5ehy0pbKuZTdtBpYKsILYoLXe5jC8
	4my2rb3TQ==
X-Received: by 2002:a05:6214:1bcc:b0:893:4efa:e8aa with SMTP id 6a1803df08f44-89979e317cbmr188639836d6.9.1771952096264;
        Tue, 24 Feb 2026 08:54:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ec694sm1029766685a.29.2026.02.24.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:54:55 -0800 (PST)
Date: Tue, 24 Feb 2026 11:54:52 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZ3X3Jni0HZXZMVl@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>

On Tue, Feb 24, 2026 at 10:17:38AM -0500, Gregory Price wrote:
>    - Changing validations on node states
>      - mempolicy checks N_MEMORY membership, so you have to hack
>        N_MEMORY onto ZONE_DEVICE
>        (or teach it about a new node state... N_MEMORY_PRIVATE)
> 

This gave me something to chew on

I think this can be done without introducing N_MEMORY_PRIVATE and just
checking:   NODE_DATA(target_nid)->private

meaning these nodes can just be N_MEMORY with the same isolations.

I'll look at this a bit more.

~Gregory
