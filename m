Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455378;
	b=bCNm5Dc2KyNjjzqfwEDrAS8aBsIFzsg1xlcodtGdGMKQ9VNg5wNbxV3m7FC9Hv7L6QRF
	 QlFyR6vkM4DKmzyEQf90/ua7Kum2VMd30BGjiPUe/Faf1oe+3XD9TVrt/FPWBjFFj0TE5
	 k84++gUNxOEu0VOOjhZseC2TwTpDwdkrFvnlHfeKouyVgvOO1QwEQnhCWhHkjkjcdXMz9
	 rrusDaT5UCnU7sOIT+5X1hqPFnpihhZeqi48vnUR9bfVPI8xA+GfjT9YbdhAYpYe3E+my
	 BNO/jL8o1t523rHIVj76jUU4A0OXdpLiBie7/MCn8kbuYgWrIHmRbD6g4+1xuDWUAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=INKw8TwmyH+edyAwKvKRS19e6OnrB/i33L5so2wwomA=;
	b=P8sHy4Saw+8uUlGmjpBp1WJ/e1cAB+xYQ+sKHb3HDahXnJRfUxt+rQ++LhGK8haii9aE
	 B7uX0l9JiUl1BALy7URj8Gwd0GHIM4iNiRHJmr2P8wgFq+O+V8POkAe82R6r0Ts5BKS4G
	 9vIZ5zJyFnrONn1fPTaFcIq546SsUVBb++TnRIxjme60nj3oUDtSnBE7ocnubKsHKjMad
	 JzF/Nc10QcIuhuEwk2es5rLRvAvbDYlOIVwd1X5DNvupjluLlqG+d3I4vTnAW0Yyr0rmP
	 /PyLolFy/s2tcE0w2ocsASAZnhwubFesOtrJo6wwp2gLITSG5VTHX4zNEf0PHcho03Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEyTO0H+;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFA606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ADFA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEyTO0H+
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-386a9c93b4eso591749eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455377; x=1796060177; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=INKw8TwmyH+edyAwKvKRS19e6OnrB/i33L5so2wwomA=;
        b=cEyTO0H+SjtAYpF6q1fWmtLq33+GHjjzGnU8kLiSmLyWjpBJqOwaz+It9UjIyW76m0
         K5vKkMQASR2OTqupOzgXsU4zxojwFYeuGUo8Jz7S53LcEO1iik7L+3tG9/7mqWykoa+8
         gyUmTPl8nfWSGBu2bIyxySoZ4Jd3K5Us/Wj8hpLxwi/SNJLqPtEkGQeh/EIPonO2QUEK
         pXwpvdcOX50VcaTwuNHXDxDBvriMBLSQldEpXjA3t/uVgQ7qQG/gcFfhHURvdgF+4Wjx
         jBBunYMuCUrlyi2l7pRmotKUGg7f0JGB3TxuQfspKTG2TsCC1D/cnPyRtBmVU0G8vtKF
         M4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455377; x=1796060177;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INKw8TwmyH+edyAwKvKRS19e6OnrB/i33L5so2wwomA=;
        b=OkcchBO4j4lD72NMJMzdTNiyBm/v/Jk4hHHXaSvR381Uv5dZFVsTowkGwOOoVOSJd4
         7fgVDZdCtFXo7y1r3bhV6fbuOpO3j5rvDmRD/8W98u/j1SHtD/smMj8n0XzIl+CnPI2K
         YRR/3ok4o6AElVKARVRO/zCRoDLhLc/FAV4hyfx91vf0xc4NKPE5/r1JeHnGpzwZEKvG
         ahkvbK3/krsPzMNwOsCcWkaKlji1O+ST07SEGudxYhaKE/MNfCkiFWnDVt/QnLA+SyDw
         HwXmm0kKTjzxik18rARRjfN7vWNftN50M/+tpbMQK0TGg3RlFXEDbqLaxJy4zha9Y21P
         EW/A==
X-Forwarded-Encrypted: i=1; AL+hErFJ90sL1RW0dBmlGNd8ERYsJutzCTOBI/wMBCtm/zRNzts4oCR7KbUC/pk+GSRY1hb3/8vbBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9uCy7CZzBCKEPJqmgKGS1o01T+IMPBPmnRyt7QKJv+i5H0hdkQ
	u8SB2I1d04sOdBDAwn6NP8qboL5KOo+po7sigBeybaP2mBe/5Ag4Wh3EmVOaydnZBpuskA==
X-Gm-Gg: AZFdTZep3MPalK0vZh8M9j0FoVfZvs64q2lOD9jUaCTdGoaLBAWe4ZN6mEDt+DFtx9p
	DYWvfBNIZXVA2KQS6T2Aih8+jOxgg2YApE1Ngpabs/syHW1bzXcxG0+AJTMAOFg7WcyLWjwpqqh
	EVODdmNaR/kB/vroiFkZilzCx2MR9061NvXMmjzFSSYqar9Z7/q7ppSqifQ4xUutflZjat2Qnio
	yS4/dR8DlzpNu5bflf2DD7YcN9zc/DL74EuY7qA9+SvqAFF3IQg6c2fBGiYFRyt9iDahWQpJs3f
	qJ1tiDbfF04/nq7qK/IdnCiNrhJPGzRSfDFVBou1jNknDhEtIClzDQE0IUkvmmRZ/U8OVfDQ5Ll
	ZpzYqdqgWakuzRd6gvXJR6LsoUv3rvFREFT6WJw80bFEklnkt4R7gH9OtZVlhEgn9qUe4CKimRl
	FDdGPZYhEDGvjO2MP8LZIW0R6aUrllRNRpQgSjPeACF/IQu+1HTqtEKLRCyHfBHKu3/q9hZx0vD
	qsyQuJWzaeSU036xOhHwIEN2N9bccQk85UsknfnPSYz7SpKdryCgkJA/ZJ0TR1QOiEn8n6qKjD7
	3jwtKSKFTQm2+P/SGx5Ys2zzAvW9XvVEiJu0SwttuizMoPPw9YbKcfhnJt8Xpg6Ze1vBROqpFPC
	E9F0LK8EYovzJjyadNKXaZG7DBVNcECgoPlhdR19uCJNgvrnXjNmrOdRQjRm2+g==
X-Received: by 2002:a05:7300:f68e:b0:369:21a:dcca with SMTP id 5a478bee46e88-3856e9472e8mr12187873eec.10.1795455377225;
        Mon, 23 Nov 2026 09:36:17 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:36:16 -0800 (PST)
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
Subject: Re: [PATCH 08/27] mm/damon/sysfs: implement report producer type
 and state files
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256506.4.14417788905672907788.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-9-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-9-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:52 -0800 SJ Park wrote:

> Implement report_type and producer_state files under the report producer
> directory.  The type file receives the type of the reports that the
> producer will generate and submit to DAMON.  The producer_state file
> enables and disables the producer.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
