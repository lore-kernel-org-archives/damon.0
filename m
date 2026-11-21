Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265445;
	b=Z4+EB3RrTbog83VFLDzLOUta02Eivo8nzsjpp/+i3HIwTCs6TswgHvGzAlvbJjkIfxJR
	 D+p5yp+AlOIeYy7G/fnjSdQwJGOmB77AV0wkgT2bdraCMpmzGWAW/MouTWmGCE9Snp3GP
	 BFH92QaTZ/TaptXxAXu9kJ0ibAYuumG+mjoMLQIkUAvlB5gCa6DDl7SOX1hOVJkf4S2VR
	 2K0NgLEwd/wFc6rMLN5pjicuMiRmmbjb8I/G3yijgqemu0UhQ08CFG5TDW2hGl4wsj830
	 McmHofJwVUwZvP/vhO6gYKzPTY5H1Tj5Qy5C6Afn3mqvVtTTy+KNVmgVv6u5s7qkgag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=205CdX5PCQW2SykzUQ2r0VNC2kEGRl78KXXpxrNibvQ=;
	b=gmU/ybAwVzI65eKatT7cnrsjoapEjK/oFKEojLUXKDI81GNld2z6ayYGDt0oD0DGg2WA
	 V79W9WPijoQgmmVYd7ehjDnWiWARe4sonlyPq0K0lV+zrDB/qtzx8hEIM9HO0UpgbHdTD
	 Sskg2s9OtbXuQ8xKA8nHo1atAHdMHHRALwysTGdP32UXhj2kfNHhMi41lebenJjnOx/JR
	 22miCN1oYnK7G3JHcL49JzhIG+Houoy+w7lO+YIvH5HZlCKqRmfc6scK08AlWxJyyk3+K
	 wcGcbUx/Mwmw5Xym297bDlvwrtPyWPkRm2Bf+K+zsv2WSz2vYUbSG6PQygriIxW/A8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qTB7qxr+;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD2606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 12:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FD2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qTB7qxr+
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdd9d0d40a4so449771a12.0
        for <damon@lists.linux.dev>; Sat, 21 Nov 2026 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795265445; x=1795870245; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=205CdX5PCQW2SykzUQ2r0VNC2kEGRl78KXXpxrNibvQ=;
        b=qTB7qxr+oDJE+FmVagQQJLf+Xy/+6VMJjzRoBr6Yf83sFcxAG6LYGdDRvd4+debcmL
         agRlosMtKS4gV+WbyDUIc4VaHtePZUYvrTL4VglJwk1qOjm2Wh2/EcKYWNmHtFZ/1ZTc
         EHaB1SPFEdRf6PPipzfMCoFHHsw+iTpzBo6hvIicpetYt/EGpqGWBddUHeRmaUZLxCLY
         C2MgZlGNlXXMzyynP7V1H56RpReNbtq1LOnGfSv1xklgsCUD5pBzOUdvd4RknrQmp02a
         WotATe3icQlNF0JJqbM5e2TP31Vlhz9YCRpnm/M8HDm3SQwOTJBAjYw+jCaHxZZvp8Zc
         Zomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265445; x=1795870245;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=205CdX5PCQW2SykzUQ2r0VNC2kEGRl78KXXpxrNibvQ=;
        b=JynxrUfFi+wQvAxVL34Ov+9ukgwkcT4bVjhmZfzBv9M81whPSFuTjHs4lEmAf4RsqS
         qgRhqT+bYhSW9zCvwMr3sbzmCLDUHmywJb24ZGpZglKaIrUTKdmSFKQ5Qgqm+cLS5or+
         012Lm7XsM6+54a9PToVbxv98GkPxpd+/8fLYGd21a735u62IHkzVZMC/dmnLw5N2iV/I
         3OMsqOUN7qXuol3tAVzlmywLhyez9P52AkoOoIV8S4LHujjY2v2mbEilMXue2OSJPULU
         +BtTai7s9HbEpyPGa/I01elRLajVTFhSL9P6Q+1mBerhnDNC6YWYEy1nVUsc0afgafhQ
         9RCw==
X-Forwarded-Encrypted: i=1; AL+hErELp4sFyPNpOVhCA1jCVFfrBiZoa8kYe+k4socn6lMZoSUO8wUi/UdtdWtzO+GxZpQNK5KssA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+B7x05m9Y77ptx7SiuTcb6WI4RG7Ya2O6nK7/gZM7dCZCR1zKZ
	MI60GRRaeckt3mbEZuK7cspKF2/h4evg3uRjQYZ4BsQLjxMjVJXDSYsI4uioGSxZyN97b0VD
X-Gm-Gg: AZFdTZcMfoSfBkbeF6EiiAmW5byCO6qqSoESQv0VBultYxKu3PLYO7SwXk/cQ/92X57
	2GaT+A9ySzTIlzrn+xvSn8HcPH3sOtuJoe0ZY7fXFWdVRURTYxjrhO03rFD4qK7HxD0K2mfqnW1
	5rtOuQ1NZH3kCocED6K+di9YkL3pATiDbxENHkYl7fuqbBgQ3Bl7XFmNf7DXqU1BWpzpZdzge/3
	Wdai7bcAVp3DKn+7lxtvJoV7UjDN4s7OOyP2nls4D4dXpFhox24p5gGdsCapCEZtILCFSsXdvv0
	1giojlfiWbr3hMh2P+Vtmf3UEUC1RDXYG7UrJVTmyaY8qjU8L5wcrRiw5suDhN2Z+rIyZl5RBED
	KFCD20rPrKEeMVzlc4gI3j9km5hSHPncLqe9L3jKQtzcqlRdE41nOoNgj0ATwmh64+M8Nc2eynx
	sDQXMMjF+5IXVEFRgIS0RAGbXcx5RfNdCEf249R95pY1CUbFf5RfIz+sSSnzGB/GMgrz9QwVg9M
	rfn5kjh1x6JXVs0tDZwpXRgHL80OPRCAp67DzeSLoTsxfAdmprlHxu6bz1xB9ueoPPPp3ARTsH9
	eAKZYwjVXOlQA2jZwuRpruyVsLvpZGyrJSRRoZURwAtfVEpwEv+PanjDxo/JvDwjPECdT6GOxx3
	ronF9zWClCRomQOs/IxWPopuWXeZa7hKZFA==
X-Received: by 2002:a05:6a00:4c8f:b0:8a0:70ff:ab27 with SMTP id d2e1a72fcca58-8c87c09e5bdmr5660349b3a.28.1795265444677;
        Sat, 21 Nov 2026 04:50:44 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c272sm2888869b3a.19.2026.11.21.04.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:50:44 -0800 (PST)
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
Subject: Re: [RFC PATCH 2/4] mm/damon/reclaim: set memory PSI 0.05% as
 default quota goal
From: Aveline Noir <jm5905938@gmail.com>
Date: Sat, 21 Nov 2026 23:39:16 +1100
Message-Id: <179526475633.4.14859465649138957731.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, arijit.desaii@crusoe.ai, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-mm@kvack.org, 
 Randy Dunlap <rdunlap@infradead.org>, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261120060741.92121-3-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
 <20261120060741.92121-3-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Thu, 19 Nov 2026 22:07:36 -0800 SJ Park wrote:

> Set 0.5 milliseconds per second
> (0.5%) as the default auto-tuning target memory pressure ratio.

0.5 ms per second comes out to 0.05%.

> +static unsigned long quota_mem_pressure_us __read_mostly = 500;

With a fixed 500 us target, maybe a longer aggregation interval also
lengthen the PSI measurement window. For example, if the quota ends up
being reset every 2 s, should 1000 us of stalls still be compared 
against 500 us? If so, the tuner would drop the effective quota
to 1 byte, skipping pageout for the next quota window.

Thanks,
Aveline Noir
