Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455425;
	b=5KmTm5zMrdfAKNwE0GbYW+DxdtdeqrIPbLFbXzlm0wqkTjwzv3HlV5NA/PmJoQvdnm2g
	 N6UleQL3KV/e/Efh9n5l92SdN1Qv9YYvL1JbsC/mrNAX0XIzkRJ4uHqPEzfL2s3WmlENt
	 OXhNQtk1mur0PhsLSINhDD12BH/TV+jy0bLzXrJpwUPYuHvBYIg3enQ0LTRX/HvqbxK4c
	 ISYBIL6jW1XKmF30gZDLFaWAHwVyVtkUd5W5Wi9b8QlAi5DklBCS2kSWuc+r4OyQit03o
	 NJLCIfCHYrM4QD2pvy8StwNqs6VgrvuUro4yGj6W7LDGRo5qfyXAO0xa86X9olXvLlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=fHKbWfCOzgC2/lN2DgsPiazl39CRCdoG04N2832eeB8=;
	b=3yhY1Y7cJU8GCZPRuZtP0x7KaBU+u4dtZBA5u9qFmHzAqDDppLoX36uH6uaUqholbtKW
	 UBAsu/FobDsVwQb74L1NdCTHr0SVKS3Aeh40/o4JpSQTb4T4x04mafVasG8xSU9QPygjP
	 SSvUigUcHNjU0fSwp+/MnJzbH01Llgqu6nGMMga66e5B2eNrJ9LxOnvcZCwpSCmVuGROH
	 qzJSfEji9YJ/nH9AESAAE4JizAjqStkmgT3sAlkAwdIW5zkrikb/O+za4kaB0PrFQ+5aq
	 CT3P+9P3jupWGtp+VbV/jkje9ToFDaQECMGdazfx1+g+KRFRFkdjKBD7Tx+z62Tw9zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWH5NfyC;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDFF606A684
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDFF606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWH5NfyC
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3862cc30b3aso838665eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455424; x=1796060224; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fHKbWfCOzgC2/lN2DgsPiazl39CRCdoG04N2832eeB8=;
        b=MWH5NfyCjhdk5AsItcKMQmaBY8ljhBYk0egvHVHxTwnQLYZhGb1KH9UFwgnNIRxvhp
         40z7A0emJ2rWRwap5tgMKNoa86/wlM1ZDE1REpVg9dx+l79bQAjqrgoSMV0rA6BiU7ap
         xbb893zV9ZoPxXjvlljpwWoc3kXNckp7OJYRwpYR+FODMei/QDCXvk1T46goffCA41ZF
         OuksCkU377T5tVAxup/0CUW7fflSj6hLhkHGzwq4nP5vqFATKjz/RsUjXarE+WEvpc2X
         /ucrgQMs6P0VJwYpa+czI8aUIrf77E0gcCtOb8DrvK6FBBETtwwcPXHGm6U/LbCS4ZN1
         +DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455424; x=1796060224;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHKbWfCOzgC2/lN2DgsPiazl39CRCdoG04N2832eeB8=;
        b=HgHqne+JSpwvR/a3/CSKjcDhVmqOnXpc5UdBZqx49Wcp1eHp+Mn0whb3/6hTIn2ToC
         1ePx7/FDt7h2HgFho4BVCH2YCE+deqbFx0V/HZGVmdDVHoRnfA0APp1A5G/0teVAdw4q
         ljPUdwodMdShU/Oim6bR0ssjBq27foEPJsrq4ucyEejVJEVtVhU7DBhxLCczZXT0YrRA
         sjDUnNJuI5OlvYNJjdTSs/mUqdYfUHLpvbBQXF+8pZG00/tCHjsqFKRoVjiEaaSZS5Yz
         +fNmU2f22hQQXyGuMqUnYFB5hRZKC6yDLYjS4iwVs0EHdQc+Lf84qehKxHxGvD6fg8MU
         KT5w==
X-Forwarded-Encrypted: i=1; AL+hErGHIRqebkj7slhZa6x8XocuHqGF30db2Xo5W1eahVs1/yPBLzaEwgR7bcNK9OzZHc4f4kBhhg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ozjoROXXk0OKMgdIl8qW3GZqS7CrePMv8hxc72ts2wFOSzCUr
	hJCwT74seZ8xdedWddX5M0Vee+zE+YgPV+R8nq9SncLMMA++x8gCa+GxRcTp0BmptVYS5Q==
X-Gm-Gg: AZFdTZebddAYs5yvDsU99OMr1uAzSkXGzw1j2lmgyweXTm/GMhckc5pNYwbDa77B9vr
	MjFTooOw6Kni7eiNEfxx0m1R4DIz6FAOTtPYqnM8GKqHciIVdwG5nlP474FZCWcIwrcGsXsEJf0
	TQUTLFrpp5JsJOe3bnB5N6r8mBQKvjypfclfbXz3Gn8BCJEC0I4b/wNl08S0Npt61BMWI+4I7PZ
	+IIF57t3OCUHHRBXhw/oXPAUSJEAOlp1DL6pCWLev9RxRscAJqeeVsfmc0QQBpwUaGmOG9VpZ3m
	uLO00vNhi582q258j/bvaf8PEvPaYt3TL62feth1jW0rVEFgMwzjKk4zF+rbEcBcI7V8j8CqWgp
	fa4DUqlk+o7uuFLJREbfjDrjJY2z6zV3WtNW54q5QD5i1BKUvu//5EIqvavKu0LUBcynqA7u3Ku
	LVSHlbyo4Emq0aNCy7WffBz/ruljgKjdqawa7Pgxcsvj9DbuNNFCO+chsv1gkNbsFcmqoTHOXhA
	6fso/a5Tv4mSxHwJGh2VBKYaxgDkS1WrsYFsIz6rVZBi6mwBdI6m+o/ce0wISwYVpXvD09WKEPL
	i+iZ+jkEfIIO12mQ8DI0Kf+TJGTlU0N6KXXksCsZBvPmhO+IEwNnVxcJwcrw53bOgfb4JSBs+AV
	YZOPuQjubVKEFaG5vwfAvFTF02YCsX4ltNeYZL1NXqmrW2oWJg61Rk0rdyfLFXQ==
X-Received: by 2002:a05:7301:d81b:b0:386:b6f9:6c52 with SMTP id 5a478bee46e88-386b6f97178mr2279321eec.13.1795455424320;
        Mon, 23 Nov 2026 09:37:04 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:37:03 -0800 (PST)
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
Subject: Re: [PATCH 13/27] mm/damon/core: introduce damon_report_exist()
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256490.4.14288363666764598017.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-14-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-14-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:57 -0800 SJ Park wrote:

> Implement and expose a new DAMON API function for searching data
> attribute reports from the report queue.  The purpose is to let
> operation sets use it for supporting the REPORT_MADE type probe filters.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
