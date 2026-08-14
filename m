Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAA46EC9B
	for <damon@lists.linux.dev>; Fri, 14 Aug 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714041; cv=none; b=t1/viexw2ik2E+xPFPi5xpMwWITlih9dOPalOuhMNRjIKJ/zaC1RK0ZrSYoDqZWK73nHOsMB87AaUIb1EdJ5eehil203ZjOB7T+A5qvZtFZN2p3n2yvRERqdLI69e2erxw2nu4jtItGG+wU7/Lkwg3/74+GNTUmZQ0XkXxondRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714041; c=relaxed/simple;
	bh=CChEzwWKHqvAbDe82pqB+EpRVBOCxUp7FVLoHlKhGNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NADRigT+W+M3LHH8DGBhtfNoEpujtdOdAp7sXRX8QwT67RNOWP30yOQTilZTzDQTAbinc9X6ltiienfR157uDWwiB1dZLLZ9p70IaHmiQLC5TCFan+88Z80yEoDlKg3VHcZfJr7TZzsauqBiy4P5gPm7/h5cuGFBHe+zozPsA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TMgwMIHF; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TMgwMIHF"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6689f36ae56so1690540d50.3
        for <damon@lists.linux.dev>; Fri, 14 Aug 2026 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786714037; x=1787318837; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4ArN/eG59F6/a+Z1l3n9inh5iDgTQHyg71JvETU2wM=;
        b=TMgwMIHFZXCEdaJqXJK4jWPfOjZunc2y8gBLbLZBaloKWm3e8EKmgPPd5g/N34z7P8
         njn2fp89mmxYIcPnoIt+H7hNBCIFzO8B03QEwbP+FZH7F6qBm/hTBkNJGqDFfH6TxiFe
         n7ZJgHbFQGLITr0lNKyp1t/uddDQPJTN3X5zDexoWBjD3CzKsI6lO9KyRPyyKUyG+OHA
         DRxdkNti8kws6iandVxfbj0xN2Efug1q8QO8hbySj4kuMLSo6XDJGFmp/PGNuhzbkct5
         leOoGlovEoLBjhWfXG//rGjeQfNtKOLo7Y0a8GyY8krE01/KD48zMxp5zikOTln9Vbc0
         Aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714037; x=1787318837;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4ArN/eG59F6/a+Z1l3n9inh5iDgTQHyg71JvETU2wM=;
        b=Igm6GD6WMbxpNSnqSHvSw99++3SMG38fzH6hQlxPqu4ciKF6/ddNOoH+8gzZ5NOlLR
         heG04TpoSD8Sl2/1oy/JqQ+bVcFa/Lqc8yhvyDTCh88q7MODQE9Vd3NTVtAFu5zv5GYF
         5j2iduDI7rT3FcpaEE86NzwR6XAOe3XaO+Bgm60rfSgn7j6q+N9aeRXurffy15ifb8h3
         yrHru7M8hsEq141Y05nUEqep/4B4RZJJ2yBoscJ+OTxcFa18pALq0JIFF4fn19TEmkz7
         x4MVv5z5vfUJORziNAS+FASiIomuahS5vEMrcg6OH2V+C9gDoBFrAWTrLRohR/3ToQX0
         GMxw==
X-Forwarded-Encrypted: i=1; AHgh+Ro//midZh7rGlKC7PotyT4IyeBbkuUGI0AjKiKz+ntnwDaQWSHYAEVhQ/j1d75LsGHWGnbj6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvAvI1aZB0sCvU8AiYcVl2TqSh7pzH3ExqHcFNyhluqxzF/w5O
	IuDZVAlEjhqXEWyzUQg/eatRdPNAw9FHbALXrA/oJH2AVfqNzHStpsmZKcPwovbOIPg=
X-Gm-Gg: AR+sD12+kIgaZ3DC1YYtgpf7KktXuYVsPl7v30ijZ2hSABDN1COKU7HQ8l7TBeoN4AQ
	4ahuDOyQAJdg+U7QAxV3CRs6xidCvOJ8aaKtBIR0p4oMDKRrIA+YBSojVLDq2WxSv5SNyjF6yNW
	R1usYixox+tMAB4hgOAyK9bgL0RWvugVVTv467tLTYfNNd16S5T0TldzafDqnNrFBMp3E4NnuqM
	6RjrMcQR8ztZC7WbayBWebxrPGVTJBb+3UuznBr5DaaZrzLMQOfJk8CZFQ5siu5ghz3rpvhvVkM
	WPsd9YQORgFjGDMPSl9LxIulo1+MI48SMkdBJ83tg0oe0mhDOEbyQwWqzNnkxcLmYKh2CFIeg3D
	UTuc9scMqtgQOp9mWgPxaN2pc5H2WM+3Qs9H340W2VhTKluaTUKqMl7swffMb8t11ZpOI6b+ozU
	NaEYyndXi9SHtqZBlt/lTTI3t7otYq60GbYZo=
X-Received: by 2002:a53:c584:0:b0:66a:3662:409f with SMTP id 956f58d0204a3-66c72ba0d10mr1917799d50.10.1786714036424;
        Fri, 14 Aug 2026 06:27:16 -0700 (PDT)
Received: from fedora ([2601:19e:8500:d3c0::28fe])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c75c9d90bsm1010793d50.8.2026.08.14.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:27:15 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:27:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com,
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com,
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	"Gupta, Pankaj" <pankaj.gupta@amd.com>, vishal.l.verma@intel.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com,
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev,
	usama.arif@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <an8Xrb5Phmvs0xE4@fedora>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
 <an0cAMh_m8ZhGIm2@fedora>
 <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>

On Thu, Aug 13, 2026 at 10:55:13AM +0200, Pankaj Gupta wrote:
> >
> > A device driver could very well just call memory-hotplug directly,
> > or its memory could be brought up as a private node via a boot
> > paremeter (which I have sculpted for v7).  The former is preferred,
> > but there's a bit of a chicken/egg scenario for bootstrapping.
> 
> I find this interesting as this appears to be evolving towards a vendor
> agnostic framework for hotplugging memory directly to private nodes.
> 

Agnostic would depend on a common standard for such devices.  Otherwise,
there is still a need for per-device drivers - but hopefully the
interaction itself can be generalized.

> How you see this working? In particular, How would the kernel know which
> memory ranges correspond to HBM or other device memory?
> 

Device marks the region reserved at boot, driver hotplugs.

or

Device marks the region normal, but boot param sets the node private.

> Please also CC me when you post v7: pankaj.gupta@amd.com
>

Sure

~Gregory
