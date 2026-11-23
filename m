Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435257;
	b=jcGSYBC+UhneIMxE2B9oVAh/WrW+nR0sPPONHMhFORlOHYq0bea+JpQZsfeHxAsNf2lK
	 rWpmmbVgSBSCllkbqhyvleabT8I8tbjdSl3hss4WKMKKxnxxjMdAqMq2DPTKJ0/FN6+Lh
	 bhSBPSBJNMuLmm+6M1iMBWJUjZsx2uR+AjjCqAEnP8zlgng9qbivWXzvAMFUpNKd9OOvT
	 QX3e52iFFw6l6gmo/Idt85DWMFNvqpGB6X/PNu//+DxjwvoVBMxpaZL8UPNUJEArodFCl
	 EdbKtqiMI9Kkk+HIMZjndGJ6rmaBqXJaUaqcqwV295MMp5U4eoAKX0/QksI+Yd+YrHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rp6FcotIUDI6/JIrdYCjFGnaAeSHOift6cwIe2xtLdU=;
	b=CKJmr4olvJKrNnDvkFMvZ2b2LAC9kJmwuZ+Gfl96WjYsLMEwywzIzme7/nDNTmK34sig
	 fvRyZfZI8UFmzyN1dr1V02dIt72L0NDf4bVucAz/0CifR7WUUApH9BrVjnqG/6wT6JOCk
	 bXYmkLhSrsbUG/uoartJP8QcvMfm94XTKB1CcdXAHU2Mk1tG45jHToy/VIx++OCcIVpAs
	 KdzH0Ijnb5YRC/G/PRBzQXthQrp4FdQ2ekLLY7OWdC8W/V/vD9PDFrruCv0clBvUSuoTU
	 sGk7Jw56/98A489+rMkqmzMiZf0XPGHm2fK2o6fBEAv+auwDFKVGAqYc1Nb3kvVcv2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxfaXLQo;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB815606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB815606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxfaXLQo
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3869f03af6aso2284858eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435256; x=1796040056; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rp6FcotIUDI6/JIrdYCjFGnaAeSHOift6cwIe2xtLdU=;
        b=GxfaXLQodgDNAEwIiEo6yw2Xy06QZbq1rdyDSHJNCI3EEYR0bKqV4+mLwfQL/dx9yw
         NdgRsIDlI5C6YgGtRkC8HLJpObeLtHWwkLQvaG3i5E5aoUq7S47Ub/jIOGg1KXa+QJyp
         Akr60u61BTFiNLEPjp5+qvWM/4WvTuTcEe33sBv85VkP3UxMo+hMio3b0AoFr2fHkPQv
         1Bu7uRHxCQlGjV9PpQaM6myBFb3VPsWJpRaUBvLTmfWz0T4SipK3Rf0rcoxNzPxHuPjI
         MEX9hOI3oxWde17nC2N+Xz+v9CUKItZX8PHBTW+OBOQVOCxQFJ4q3LibUB6ScJ6Bsugh
         4HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435256; x=1796040056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rp6FcotIUDI6/JIrdYCjFGnaAeSHOift6cwIe2xtLdU=;
        b=A/h6f8ZS1ltfz2p/gPwWuxQF7Ed2xMi2hr1Dkbcuzlj4UA8Y66MKUJlmz0i0/j1I63
         a5zQFYQwmep3HbpFML3LK8VNH4Ol0HW/hKgwBo00eBnujkCQdHgmeRTNxNh+nS0zivcO
         8cwqjFEGi9ajDeKq9tJQuyf7wNnHnRYsaRqgZDDEWDyCH0SaJaVDk8LLqmU4WJRqjK/I
         uu/4RW4uwqTGVDGJOa3Roq+1eaIybteUD9Nb5NnY9PHEmJ5a202iRxBJ7t24BwVI5Gfs
         nBgJshPmbQZcZBfzp6kXoqVPl6tsuz6ugntXv3zMnsWO3nDKL67HsM3r+sR+0ThhlFZT
         KW5A==
X-Forwarded-Encrypted: i=1; AL+hErF9JNcrOicQ8S3IHaiUpllatn+kfk64ke9DtXgd3Rr5huLEPTCwP9PH+/pNOVVLdiK0X97a0g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9bpY1g5uyVIZW+RTp712zuZX0/CYhDSnRSp2irv92qluWpxyJN
	A8SsgMiZzp1fxmnv9/nYmz8zcjtMAGHAj1xoWCEk/KKVzqD88i/gfp3x
X-Gm-Gg: AZFdTZcElTKIfJhk3urpQydoOW1QBW4LsVlwN6daRwPiqAKxvZBpJr7t71YwO1Um6tL
	K5rr/0snY0OYmflrQuOlxJQESnU/pnPbWi5q8PNX/5cn++rsPdtFm9+hKNmYMXg7r8HOUuAfbXu
	d9SSFjDtBd5XXvLoOWK92kd4qqeIQIw8MszWHjCqRfsc3CY2rK/9j/rcityhUcS0UgicHJcmVOm
	2Z8QEHsqZ8k1dbW6j1GX75wUSst24O4XKZvay7ymC4PppkB9/2ckod2Gt05jQA84x8s3wZP7QVk
	K+KF+9RMqyxgDbbWMDuxX+qPNQBiLShGFBfnILXaHbf+axJ8SrwfNHf3Peivzg2ZPlUPSv2+M8m
	gW1EOHYlPv+ZKzzBx4wzF4L3+jOVYdHjQnvDcXCiHREtvdzDy9e/GyWbA9WDGo/vNvXM4VJLNH9
	wlO+G+TW/mRQA7/YQn7l3PXZFPpzdq6iuC3xAFxzBOpFk45dK6c0Je6RUACdEs3aKswt7MVW8Ar
	KfrVoRHl7x8I/RrKbKNYqaJTaLo3yTohX1Q/+kPjRZIcQwHqg8RHTK/SZrlK39EZKMY1A+2iZBp
	zCpTbSzhg3aqRSai6sPEO3S6zFP67yaNH1hZAWSQiDPNbMvZgTS2JbvjHUPnpJBlVSCcAKmcs8v
	s1+e/+IJliLLgSg==
X-Received: by 2002:a05:7301:6482:b0:386:b39a:883d with SMTP id 5a478bee46e88-386b39a8d30mr2312894eec.0.1795435255730;
        Mon, 23 Nov 2026 04:00:55 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm35541692eec.23.2026.11.23.04.00.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:00:55 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 15/27] mm/damon/sysfs: add filter_report_type file under probe filter directory
Date: Mon, 23 Nov 2026 20:00:36 +0800
Message-ID: <20261123120044.9172-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-16-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-16-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 12:59:59 -0800 SJ Park <sj@kernel.org> wrote:

> Add a sysfs file, filter_report_type, under probe filter directory.  It
> receives damon_report_type from the user.  Reuse
> damon_sysfs_report_type_name struct for user keyword matching.  Move the
> definition instead of forward declaration, as the code change is small
> enough at this stage.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
