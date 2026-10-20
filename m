Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512632;
	b=XAwZ80iD5TCdoLzN7CFoQWFx79Zp9xK2E+f5Nbqy7KzzqPziR852c2Ebwv/eYP/b6NLi
	 LEXvvfSJog3Zv605GJetm3UTFfyNT9djHI2mhmXDXLCSV6Rx9fUugwhrhLAsIuUCaQaoT
	 rE1vtOxxLHAN1ZQEHdrWUxLmFr+TwfnSGcwysfeLYE5YTyDqBSOJr3gBmJua34pjlR7Tv
	 iOfo/B2RHQotWnAYqCigomPkdhGvtC711t4bOFU3F4NcDqEq/hk71f0J2IZjq+1MBt/yU
	 VLhsiVlXEqDvZ3MlOaBwEjgU6Nbbr4oUGb8dq9C1mkLO5an+eg7Q8UK95J+x6nkHxgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Message-ID:Subject:In-Reply-To:References:MIME-Version:
	 Date:Content-Type:Content-Transfer-Encoding;
	bh=c4lo9c1DzgFzppkuIe3m48wNpvzpTiu2Q7BfuVscJUc=;
	b=2+CmxsVADqa6rhjHnlK8BV9I/B/5wb/RAa6yTrOU+f3TXuILmpLhPZYoR0qJslDRytVX
	 D46tomxHNmPQPJlWfZXuN84jlYQVkwZbvoG9jHv+2/bGwpXaZL29Cq5E8KIlktdD3IlY3
	 1aY8WPQdu+GWQT0RP78rVwImpPcptusLIU38WMbGGX5g3ucX9d7aH3+12ZOiWPSE4oYXN
	 mi8ntZ13QuIg5RQPxqav9zC1w0Nr7Hnbx6aRGI46fsVhwUWh1k+jOL6fxnoFSEYiv5r55
	 dkP5f9eJBVvt9+Kzkgb8KVMfK2Lf7dNMGrntedQLxFSKuzfiOd3+DWO3GUFF3Oy9N4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EZzE6woS;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517D606A324
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 16:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A517D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EZzE6woS
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so953971a91.0
        for <damon@lists.linux.dev>; Tue, 20 Oct 2026 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512631; x=1793117431; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c4lo9c1DzgFzppkuIe3m48wNpvzpTiu2Q7BfuVscJUc=;
        b=EZzE6woSlsmzUIfO6lVfRdOg7P2ZJrOZTvGpUOhTp17mdckoaFgBy769Ka7lx1SyYe
         Q06oCtOThKDMgwILVcrXaQm6mDjLeUIu0J/aSoWAmpN+LIFrsSwgalQH8Ge9mGUX1DUn
         NCJ1icMcM7k8J1QcSDpCF/AO5cJ6KxAgYeUvaKs3YWM55ZHb0FGVW3jdkQlLtLxk2jzP
         8RwP5/Sp4U44/xpg5qxCVki1TBGSMYZZFlpd/UgL1ViBt5Svvf6sy+s9vjjqM60hErH8
         LqIvAwJoRf0e5NMs0U28Ne/C3sNbfagd43dvOwXN9+03bDHgC+hi2D2YVf97Eg407rYh
         cfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512631; x=1793117431;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4lo9c1DzgFzppkuIe3m48wNpvzpTiu2Q7BfuVscJUc=;
        b=CjQ/Kq2l0NY+x6pq0+Cm79RvqjcXp3f3+JvlUT2fWU1lMwNms37SCMqpeprb1N8c5Y
         /zGTiEsq0sqD1p/PsVTJL/IhbxY7vSl8SScd8QZ9m7r5It1wnoLgtcCx2Y07mlQDY98b
         x4LD7HR+G8+OVK2BQIddStQZ1NHmbslXFbDu8ZlJcK+VBFdKsiDfVDgkpIS6yBN5EV9f
         KpJC5DPsGo50ZML+PPlx7nKKIbV69jxf4PWrLRBKV/21S6I+cuPMq0AhUmVwWmKk2iXz
         P8xXtiRTb8PzhTcGh/PQ9KjE450vXh9Ns+gr+guKcpBOGC7jLSkQUtD+WlsCz4LC3Nvn
         FKWQ==
X-Forwarded-Encrypted: i=1; AKwUvByfBepx0kdwp25q8WqvZ61uFf9xDnBAB8PiTnig9lPodpeRfaZUU/y1Q75O/gH1Fe6VGk8CAQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYL/BoVY+aj7UjlV/8g+nauMjWsq4RmhDRF/vScOL+j++KoxiX7X
	wVj82IW07RH1KSI5KTbA6twA4Zs+C4bBC3NJvW0vROvIf75pk/ojUL5P
X-Gm-Gg: AYBFou1eulUo6I3uFuf4wN9hninvFdRqVFk6UQpu5gGpQiJzletGyDQwCwU2bVPPqqa
	FWSZDESek5OxxFg7nW1E4ZwsOgQpkG6sLuWHBv5U8hNCt//QsNbThQbC+9IV6PeveTlOijxl2Gj
	L7dV1z1LBycBRxqCy3pZ2/WQZAK4iEv8poZxR+TAOn9/mQBuqeX039WANgjH/2kEeQmEmgL0XRK
	FT3zpreXHmHERmWM+hLHwTRXnBBN39y0jQ4+Lfvvwr8jNqQT+XQsuT8meJS2nDrQH5LhcCrMDtC
	wWSveuHenlTki8NFvgdfIJBdSuwrGrs3MfBLxD+Snyz6Wr5dadH6nysNQ5KlhNx1DGOjzSr+355
	C0giJpI+fwd8Ko5V0A5hdHKEwGQKDV3TxATRSweV2T8xtnxIddHyDlj2JBooU4KSzGrbIJRoEwv
	efEbRadeJ1bkO8S9WShVP3GmBQNCuQwCSqdNQoU9a3JTRIz8X1XcdINjJfsbJHtjVRCETbom5no
	GwpObH29fa8eXNjDJSkglU8SHjY19anwUCmlPeH6j7rxJTtIAQqi10yF3IZxwnIah7/5Ok=
X-Received: by 2002:a17:90b:5112:b0:3ab:c80:9365 with SMTP id 98e67ed59e1d1-3acef0f47a8mr9810302a91.42.1792512630823;
        Tue, 20 Oct 2026 09:10:30 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80cbe295sm87743a91.5.2026.10.20.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:10:29 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <179251032453.2.6166799753856435091.damon-watermarks@gmail.com>
Subject: Re: [RFC PATCH] mm/damon/reclaim: allow disabling watermarks to force
 reclaim of cold pages
In-Reply-To: <20261020135822.85334-1-sj@kernel.org>
References: <20261020133233.3920818-1-ruanjinjie@huawei.com>
 <20261020135822.85334-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 00:07:00 +0800
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi SJ,

> setting wmarks_high, wmarks_mid and wmarks_low to 100%, 100% and 0%
> effectively disable watermarks? Have you tried that?

That worked in my test with swap enabled. Agree that documenting this
combination might be useful.

Thanks,
Aveline Noir
