Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015260;
	b=QPLuiiFchSW5MRUz3HA9ysTzkA5Pvwo6EPLiH5ey0y80wh9CYeYKdw739krGnQHO8vJu
	 zkvv4VDtlrdWa64q7DHscOmRl4sYIRdb5EdfGdxYgesQO+U2NgUAinghToogWcoUCfA+D
	 NUQ7dv70isXu+W0qZODlElqy+o7esxbPGY7csOATCHBlUcmPtf5hk73LTYDL/S4Dg4CcP
	 R8LPP3dZTZpV8hJpnk8NPJJNtnADlg+cEcWnBxVImEYuDgkyKJN93RfRB0ksgnvVeiWP9
	 v6b46smmRWBExKS2vRg7i+je5Xq7Eor8zYuFpO7qBJEkaIIAN7aTGIEDg6dYYqUYaiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
	b=LTPOn7H2ubcf2akpbIW/Wbc7eR1d/4YOk5HKHHix8sOBe9vrq80Jxi+DsIKlp+hDz5EE
	 GEBGrZx9yN46cYm5TVOSbm5Xzzmc+2nXqZS/E94sT8KG7NWSpFeX5UNhg16MUpciTqzYn
	 F8DILOGR7f9hPOmYxxMXDaaaL4//3Octdn+vjAdeYogRu0u0LcQ0zuy2pO/8kIzsLqNNe
	 PWpcGWOxfasC4wlRaSruj3Mprgi5ZksGotgfHAS96rwbUyHLvxhecMsa6b4ad/TorVXpM
	 fgwDAvmyzXa852T9nf75krk2/5gWNro4GYFzb87mb48CUGVD7BuD34PZze8rCCbN5WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KuPzvaM4;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0B60A2607
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE0B60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KuPzvaM4
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5361e313e63so12184901cf.3
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015259; x=1795620059; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=KuPzvaM4MzLXN8hnKaKXCzxpPkoYSIzSJxAOrCHnBsmtx0X3qnvrYypyZdiIaMiVPZ
         aDxZZJazedE+rry6iXrbL8QAKlSsTWb5B0UlZBrUfhFnp9fi8CPL5aEu26L3bSOfggDK
         qFNDC0A15Iaf3kHwmghqPrhDPkup3M5JWy1yu6LHpyd09SX9m/8O5J/CdP5kCvyPtKaA
         ydYRUyDPnJJqgDNY9TzgcpRKAZDtyZl3IMI3PwiLb0hOJeK3cRAiz7vbMplr0ADPBPe2
         DvgjzJJWOGhTE/wenupqcJp05McD62imL+ff/TlxW0rYvftVRYXsVdGvmpxjiU/f2yrY
         vzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015259; x=1795620059;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=U0XhYjOop1gIiePXZP0Llykqq8+M4x3QvS6IqkNoOQ9jqItnEE+TKRZjgIgbUjKNGW
         oymt5QMXOgqvz64smbkXQQqaYFkPzjBWSU181NM2vUfXk7PHpw2Fli+k7Vh01zHPwUuc
         ksBaGqiWu1bnT0eDzQTkByFJAUoAehdK9VL30PgzjO6ciedomSSGJG6cqAj1TZZc00NQ
         Jnp2rDFbd6/rfStm9edePPW5kEQOhWabYaAtCJ4MQSy2zVuF05UgJw5AJObS4CZbjuZm
         KmToodQQWRv63uW4TMJPmqNJVLlF0+HkQ3esNn7/21hM/0eomY9KUeNRe2xVxiMl6G9g
         XYUA==
X-Forwarded-Encrypted: i=1; AL+hErGs7fkIeaFIiKyXkF8RHoC/X8YdTREdDtsm5zlg4stbhQCiVl2ORlCMtgDZE+t8n1iV8YK+yw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+KcmST+CyYxs8vUP5O8+dcZ7ydaf3nYXZw98e5uiMgnKOhLJG9
	rqz8Tb5FmGnlyeDaiFVH8PVyqtAchgC+uoYNIJo+WOD6+y6yZ34kK8/mnoaGCitW/gHMnUiD0Dk
	+tRwQ
X-Gm-Gg: AYBFou2VIT8M979Ykt/MPdKNQLovNXBPh2UMCJJjdmxERoPkMuHThBXJ+WCqVxwg18D
	6DMAFnTXEuW0P5ThiGueMH46ljy902F0XIwckYILFyV9VC6ywAWkiiK+yuBfu0nPleK2XxmdwDC
	trmO7Rh8KdS/reHSY09vDKRwLIy1qHaZzqBxmdOphM1JJrU8XgUOLFXkYa5TUX3GFBjWkNKB4MP
	MCg+hUGQ8Rf3Jjje5pya+jM7Gik+XdbP+YWVHcvEw5zIm23eW/6ZvplUTRz+I6+H+SG7SOrPgBx
	v7/OhZdnunz57jfA44O2d63VO5IeBm0ED7OgHHfbSQoR+btjcSF/rUIjj4UagZeCjmV5j2yPAzB
	sLvGWpnMutzNX2Czg/GYDahevNPC7C3C+zEgsDfthNwnpDFJOx9CDlNg7/m5L37OaZ+4IgIcLcp
	u287cay9jKVflNLcMEVlP2Z+LysFb9863Fhd7FARacsEw8yeqMGElJHWfd2Zp+QH/iJV7MPjppb
	6iLxb/C5ebmYUBu5Fzy8w6otQejlwzbX6K/xth7QUEHVCP9xpnvwVmg/0MjRkcoAaovG2eFHF1h
	eyVKuDHOzdV8hU/FFhxoU1VzbD4DoJ/Orsbn8GGYu68widDDiLFG8Ey0MWbiwa/gmJTT4CahFtN
	q3OS24yA=
X-Received: by 2002:a05:622a:a0a:b0:55c:66f0:5bf0 with SMTP id d75a77b69052e-55d5a656766mr42047121cf.39.1795015258621;
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921167f4725sm19632976d6.44.2026.11.18.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
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
Subject: Re: [PATCH 02/22] mm: publish and clear node memory states via
 helpers
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
In-Reply-To: <av1ZBTpLpJC6DJqA@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-3-gourry@gourry.net> <av1ZBTpLpJC6DJqA@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:20:56 -0500
Message-Id: <179501525661.1206716.17622543796948053737.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:53 +0800, Richard Cheng wrote:
> >  	/*
> > -	 * Check whether we are adding normal memory to the node for the first
> > -	 * time.
> > +	 * Publish this node's memory states, including any newly-normal zone.
> > +	 * Hotplug never adds highmem.
> >  	 */
> > -	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> > -		node_set_state(nid, N_NORMAL_MEMORY);
> > +	node_set_memory_state(nid, false, zone_idx(zone) <= ZONE_NORMAL);
> > 
> 
> Um, so I am not sure how much cache pressure this will add, I assume it's small ?
> 
> Just want to point out that the old code only wrote these bits for a node's first
> memory. THis now does up to 3 set_bit() calls on node_states[] for every onlined block.
> The result is the same, but node_states[] is __read_mostly. A test-before-set in the helper
> would keep the old behavior, or if you would like to keep it, please address in commit message.
>

Hotplug isn't on a particular hot path, but I can test N_MEMORY before
setting any new state and just early-out.  That would keep the behavior.

-- 
~Gregory

