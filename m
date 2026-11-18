Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017377;
	b=X8XPxclTI/vOj79AomhBaXdZQN/IErta9WzqvSkf9k0TF/5lIXJVkdeWYUwVdacKgSe3
	 0jESCN0NtScZHbQqtq9lzJhu7sdgp6i/AUWO7e3znUTXvlM/rBORxbANMPLlOH4PuZPCb
	 fQoukaDbA/zd1wLT+AbgDS3xE7cYJAVVhet9IhfxE893irLcwb4F5/TybyONpYVhB6/2l
	 iG0WJKVM/+MJHTE+1BYbOM1g35nENCscwBQVBMNIGA7ahtERok+iPoHf7BIPMShcAEyx1
	 uW1uTNpiwqr7OSQ7Mv7UernMQRonB41h+iifNHgEfD+yjRVwCpnxzD2WEpm6ZMaS7TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
	b=L/XpFr3LJNNquSd04DFsQ6WzpvF1NncPrBy8nePusm1wMuNVMY0K5BQhjzK0ns6052B3
	 Lw3RwoDvftL4Q8/w9OxARajkNbmLy6/fn5q7kDyyHC81CxdT5wfhzZvmF5OGDQDIF/4TE
	 rShuBfHBrnMWK+CwpF9358UPpA2eUQiLxg5KwC5Ru82hsjCf+v0YmfBMzWpJM1H1+mS1I
	 lwSlXPW2lxIDqXbNir7XaZ8MZrz/X/J32S8wLLsKHSBtAyg+xlmqhkRIJai4alYrzW7nG
	 qHS8zE535ajuYm28zwHvhZnPPIgXcGph9AFEN/YX8sB55bbC0zVu+RTnztfR233qhWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=S0L7zwZd;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76BF606A320
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D76BF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=S0L7zwZd
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ebf4cd218so4361936d6.3
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795017376; x=1795622176; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=S0L7zwZdM46cBby3vC0oSkUe01o+3A7Zjo9hrcc3sPHP1Dk6nYzSSPDcvDHOgPWXqF
         x2rl3PAohlJT1MGmvHh7Q5rIrblnqJ9NQt7h+zfFaWF4yJyqh+UGCsx+wIjtYjsJgW4l
         BvvUyPGmE4j88Qm8WpRZOWjS2I0MAV1goQUB+lt6RCoisOW/PDkOWELd1IZs03qF5A1a
         2IWtEV/raPy3c43l6t27Qblwl8fJUH9CC0mN+Ablt5W7xi3THK9DTbyfZADNNl5tA7hn
         t4q0U4H9PeC8r8KSmzudZaW8DockAjfQ6ZkTfC8HG2HS4ozHmiu1lG10zVoE1NxDeQiG
         QnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017376; x=1795622176;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=RK4/AARN4uukwI65odKA7mfHdBfh0h0zkhfCYWj5UcdI6l/31WSmcvSnhgP2KLQWO+
         2czLbq1hSrFgw5hU3TCltC4cTobTVRd5wer8Q85haIKBmPZsbTB5VmC6LE8bYfAssq4Q
         dHEctwSc7y8OGg7UkfRrx1Nykf6QgUF1+uEwt09uC6FY2ITqnCBn7+IduthEWH+XJWnm
         1nnTgK3vJPL+Ze7ADky0fjBgSRcDCB31bKtRzF7Qd/nrmj1hj/1pdMo+5Li6AEKqpNAe
         o+HeVkwNCDFSyxdI0E1I0KHNyOfZZ83+hvh/EaMCxjjeqkx7j2iRGVu7KDPoldNIv/NT
         +wZA==
X-Forwarded-Encrypted: i=1; AL+hErH+PhYweKPr7pS5viz1s6t4G8bMev+BPhJh/v9FqZn5TkFRtvrJ3+aAqVOVjlixdUJMcgeqNA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/VdlCeS25nrneFIqqEVPMO5D5PAb50cUzaP7J4gEOZtJI1I2Y8
	RsEE+NoJMgY5pHT0JEKzDrDfjOc9bv+16TuYajKKN+MuQUDP9ck+3dyEhmS9C2eB54ybHIa72T2
	OJtuT
X-Gm-Gg: AZFdTZcpmVfW1ql6wuiJXlqFT0JJAWJJ8ErdfSY8baIYOPYlCTeoduzgT1A+hIe3aHr
	KQ1q2aLh0GjACRRlus+mCgKe/9zxrpDosiSTL6ooLXL4ohFMhB6livKAD2h8kGQxYiU2xB8KCae
	uwozWzu75b2J5Y2eaYBLOQzehFwdrrK6U9bTRGxk2Qtz4DTQhdtok5PB8P9MjDi5IUD8e6p5q8R
	v66+ddUIreukoHRvg5+6WFAJjQxULufjeZ30U+2eujcL2p9OMlEDypv14KkLTZSeQB4MH9vfJwR
	TlZLGJ6arJsBxAlIwu0JWEk0nLWYf5JQnbZNR8+nlQFUZUVuhEGn4M3Yaq+HSPdP1+TgwwYeBs1
	TaSK6SaTpclw3q9Yncrm9STuLm43Lxbu5z52WfR+Eretw5l8fDGUZExclShaw/6Tpf/JiEdleoH
	zblh8BXShHZXbDg0pSech2TC1EAV681rY0eRxTAzdRjhTEo5uYDjTfeGaM3ST6QyTl3joyPFSRK
	0ddqVD+0Hjb1Rc3KU2O2k76dTGEqWsGvIBkEG9gvDhvQsD5kvS8Czw3tnuazs29GTFBqtZW/3Ec
	MwykRVMRMMSSixTLUdtHO6REDl4XJCHpjAdsrWFbhwW3aDVz6ZsVpe6OjH+HWeZ9K60SIstHtw1
	oWBNcCwaxRt7a+v8ZxT5K7Xu3CQM0
X-Received: by 2002:a05:6214:8013:b0:921:1890:b77f with SMTP id 6a1803df08f44-9211890b87emr29798426d6.47.1795017375668;
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d28215sm24719106d6.16.2026.11.18.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount
 policies on common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av3EGWuHX2JDdlrx@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-6-gourry@gourry.net> <av3EGWuHX2JDdlrx@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:56:13 -0500
Message-Id: <179501737390.1206716.11014097946405277594.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 23:30 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:42AM +0800, Gregory Price (Meta) wrote:
> > -	for_each_online_node(nid) {
> > -		if (!node_state(nid, N_MEMORY))
> > -			continue;
> > -
> > +	for_each_node_state(nid, N_MEMORY_COMMON) {
> 
> Maybe I overlooked or somehow, but when do we have the assumption
> that common memory is definitely onlined ?
> 

For this particular case it's not particularly relevant.

This code only runs at init time, so it's either got memory or it
doesn't.  If the memory is present but offline, it still wants weights.

There isn't really a bug here, but the existing code could also just
check N_MEMORY and end up with the same result.  If the memory is
hotplugged later, it still gets weights accordingly.

-- 
~Gregory

