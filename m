Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015080;
	b=UTGw2d6MR8OF5BsV9qdKnQbSTUwAn7Ya9AXf7lRP9fZJdVEfoIfWUm7wkQcmvJ/+7spW
	 xh6mTnMhoZEIJdpyHn1vDoenGNOr40Snq1RUo87PkLxQ88nwqNcuXwn9ATcQ4q2G2Dp3o
	 x4pI5QXt6XXpib9ojlh+M2iHviouUENT6WcnKqnBtlDQNb5V4WeNOMomlkTVJ6ChWLtCx
	 ShD/mG8t8Clmsv2ezrjmvczlLQoenmutwVV1peeZoHObI+p4EIv82YWY+UPPx4oVjCirE
	 PnXaG+bM1ELQQyUrWNHvAJBHlduIPYo/b6hpXCL8hGNI0Cs8xXefq9LaZ7jNo0EvSsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
	b=QTqIdKbVm+D7VyZZM20jDuG9VEdErVgUyk7PV2E9tymzcBogJuMZjvjNg1T40V+A6pjo
	 5aO1r+3LeBTfrZAJyVUp/KdAYeroBJVz9mROMI8Ru4fXTI+WiOjmvwgg+oEelItk+Mu1K
	 X5XpihfjikhuI54X30kGJrIKzPsaf8WzuDNfL5Uv9agrcI4mNnT0ooaepR31udOe5ZMui
	 pMq/u/cVCcKNtMRBYsX5PgsU64Sg2SF9cB1Hj0eESVdmjhZ6G5oWNRp3osT3+wBKGB07W
	 lIRKr5MRw2iwrTUEaLa8NoXc0SavlJZj+r2BTAmdsLmLwjLHRTBuoVBiK0Ic3LSc59Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uHq3uBCN;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881F606A333
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5881F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uHq3uBCN
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-92119da3d37so5684786d6.0
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015079; x=1795619879; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=uHq3uBCNePWFWEU91RACxzfkNgCNnV/IghHZOHEFVv8Fpd+9qBQ2LzYGFteeTX0eVC
         3mGSB9G1avXXbNI4vCuyKLjyG7ZTqI1ZT2e2s+W4WZFIplgsFruziN+IzU4qRHAzRmdV
         tMsjYSlDpZO5x9uou3VCfKEqiPydrtjURQoTfvKRmlSGEzoGEw96UXTjdrHDQ/G2WiZu
         tmA8XFTum95zRbQ9XDjDSd5rPznE8aBRGmci2ExTIPBq0DNCUeV4prubBvFheCBU6k//
         jUw54yq338uNsppEqys0LfBnjPsL/yv4O3isPC84hF6GbbedjfkQill+REMOimnk9aes
         GPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015079; x=1795619879;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=AZTQXQxiSf6iZYFsyZVEQrf3Yof7wlfd51SeQh8x5BXHi7uyskM6+XELUKVMzIuTXe
         u9TUElYaaxaUuOjzmBQL93B7dj39MDnGm5aSBXZbn8+Pzx2N7gaM0KNyFwWC3czdSJi0
         /Uv4q2DhOP8455KumXrX+7QQOtJsKowgbatfN3yRgTXRLQcp8PZDmpaYKgVTTXqcZJoT
         2/vhLjgpvN6krRavuW01OfYe/N4jWzhIlSspfqHAeLffGE+h/i0tMBkvfn9HPHqLLNjC
         98K/Xe502aY8uw4xPj4QdTA2QaTz9bPlbfl2a3sB9kFeOYGbIp+o7ipRlZzK88rcG52U
         l+3Q==
X-Forwarded-Encrypted: i=1; AL+hErE1iz++bnAJK1aQwz9VfcZVqeyvJqNRo8BHjlUSvh0YOUjB9R/IeSONniKVyxBqL1wdJI+HbA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+jBjDo0sUAirTvAGP+6Az2iQVLz8nd/+5WnOTrMLi1WS5ThMM8
	9fISaJfQSowkEdchQkOEziRCth2T8TynLxD2KZjP/1VakQnfTM/eOSly7sYvNUfyKfxVN5HURLi
	UB328
X-Gm-Gg: AZFdTZde0xFCpGfCNccIZdfove2ZQmyFqQ1AG8aAIngvD11SBQgbUPZyaPhjPjkaTVO
	FVnk30e5/2tDf/VSAZ01aPpEVXNUFIwrThdlbn+PmeVS4CK6GLC0/IqEnzqPCSRoDNLx91CsHeo
	CwCa5sLZotxJJh+dk+sWBc8qC3ROncUsCC0Q2DbKbTk/HuWZQfjxfm3xqi0aTkXgE7cexJpEVcC
	ieIt5cRCgLjKXvtpW0rVbw7jNRquMR+v/Fmt2fepAYEgRfGP05l0+d0+Sfdr6iDG33jhD/nwUk4
	XJGG6CvgbLqUtQN3zx0rogMpW8xUe2+l/rPwhiRi37yvpiFjwMtGQTB6X37xKPpL8lyJozjk1J5
	1fb8PtAxrTTdI/qJYow7AVfrnrILWvl7sazwwEGIq1jpTmeu0r+knAzYCL9bqbygbKwmZAKDNZ3
	kM8hyRIgoUIu43Jh8XUIkzmMNXf3EViAtn8HvZA2iCZITgaAg4V3UVwEn4vm2TYxqo5h73Pek5y
	ViCg1AHqWMflu+gFNRE2RDIHuQRQwFGdb7S3MtZimr21i1BF6C325pqi1XkPgcsP6Lme3SQPl+g
	mn+CIqqLmT20tacVA6zMnvXeTsPfb/VLgbuquSDwEI4srdWvgN5cvOv9KMbviDsO17bX5arzmJd
	AMTRoCs4ETsPYwiqJSfjQRREqLi0f
X-Received: by 2002:a05:6214:5d88:b0:91f:2222:b498 with SMTP id 6a1803df08f44-92114f8f66fmr40206726d6.27.1795015079071;
        Wed, 18 Nov 2026 07:17:59 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d35dabsm23793796d6.17.2026.11.18.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:17:58 -0800 (PST)
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
Subject: Re: [PATCH 01/22] mm: add node-state-filtered zone and node
 iterators
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
In-Reply-To: <av1hKrtcATVjCnCM@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-2-gourry@gourry.net> <av1hKrtcATVjCnCM@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:17:57 -0500
Message-Id: <179501507729.1206716.6880334614636468959.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 16:29 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:38AM +0800, Gregory Price (Meta) wrote:
> > +/**
> > + * for_each_zone_node_state - iterate zones in intersect(nodemask, node_state(state))
> > + * @zone: The current zone in the iterator
> > + * @z: The current pointer within zonelist->_zonerefs being iterated
> > + * @zlist: The zonelist being iterated
> > + * @highidx: The zone index of the highest zone to return
> > + * @nodemask: Nodemask allowed by the allocator
> > + * @state: The node state the zone's node must be in
> > + *
> > + * The state filter is part of the iteration rather than a trailing if, so that
> > + * this expands to a single for statement: a macro ending in an unbraced if
> > + * silently steals a following else from the caller.
> > + */
> > +#define for_each_zone_node_state(zone, z, zlist, highidx, nodemask, state)	\
> > +	for (z = first_zones_zonelist_state(zlist, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z);					\
> > +		zone;								\
> > +		z = next_zones_zonelist_state(++z, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z))
> > +
> 
> A question on consistency. This one is a single for statement, with 2 new helper functions.
> for_each_populated_zone_state() in the same patch uses "if (!cond) ; else" form instead.
> 
> Both forms keep a caller's else correct. The only difference I can find is that the if/else
> form give a -Wdangling-else warning when the loop is the unbraced body of an if.
> 
> Is that the reason for the 2 helper function here? If the warning doesn't matter, this could
> use the same short form and drop the 2 functions. If it does matter, should
> for_each_populated_zone_state() be a single statement too ?
> 

Yeah I was getting that warning from various checks. I'd convinced
byself this was a false-positive, but it does look very funky indeed.

Let me look into this again, it's possible I can massage this better to
use the short form still.  It's also possible that I should just use a
different shape entirely than trying to use the existing pattern.

-- 
~Gregory

