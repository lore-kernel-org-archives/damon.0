Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455462;
	b=QhdvLuSJ3JvnoHqEvd3eCco89bzawH/o3qEQFZyoDGtnjrH2HXTZJVqA3/zv/vkFzRtZ
	 53OlpBGiFnRgVYBD+XfZoV1ftZoFrA0KBczSRIV2KJKndUe2iOS6/Uh2c8oVW1TxrQhOY
	 jYPgMJN6bcsgxcBk3gW4nfNFPthOoTxKo2oCYu//qtS88cQjRizMKjFBms/2W4uETHr/8
	 /jMmFAqfD1KkvVf0D5khj3eL+Hy19JHu8J05BQerWjqqz+RWc4XEnpZOoaB8h49yU1nIf
	 54RcD6Xeh6yrihfgKDF6XBFpMKmYY/bSAv+nzCstWU1rUrhOZ5KsiXBDDONLma/nUNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=PZHBxkIsMI/Qp+ucOhJHKVnTKpB2RmQ5oFbvkHFx1xQ=;
	b=jdc3z73BoLzB2F0aZ1731mzcp7c8v/ZML6uOaRoMVRLcEJqUyP1pLE3cdNSH83M18FbX
	 STRdAbMQST8O/x2Yp52SvpyDajAInI1nRhbgjkZjNjsX+XYrmKX3h424zFns1UBwk5RPU
	 xUcGkj4wnlJRENhrVzyFWfgkD9gRgUSHDC6FqmYX8TfXIlZmQl8PJ6jYwE3zLSxkE6Rsf
	 5MoRSEjVTCC6ZbV7UunCYVyfZ+pR80uGp5x4VNOOHNl5liPZRZvIMSgWKYDHOruhEJ9/c
	 kspxfvdQFjPIPaPNBsKonR8jPEoakkyBO1GwCchgtTQo2xzD46x6y/J62NuNF2VtIdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UixXRNiX;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CB606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF1CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UixXRNiX
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3862cc30b3aso838753eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455461; x=1796060261; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PZHBxkIsMI/Qp+ucOhJHKVnTKpB2RmQ5oFbvkHFx1xQ=;
        b=UixXRNiXxC8gzJGoWFwrOz4tBSWFomHDIZLNCYjZWBUfN30VyCE6UepUoKWqJmZS66
         RRp7o4vieZdRZ4gs/PddcF1p9zvFrE7P8y+WTthlSSiEd+YlIAafqW37CjfCWqIFLWzb
         cXPGf8shfZx5DzftLeUdoxhmXI2R/bDM5ivB9Ytsd3hx+bDoviHsEgJqBjHLBUvT1m2K
         uj1jrxONRvwLhimg+DLT61YJ1V0acdewYvRdjRI93F/sgLRqDnRtY1VmY6QW7WQDenqp
         9VWyrFpoUcizLEcYfLXlSyAQEyaWo/klEB+3ieiCUV1GybWuPdHpz/5G7+9MgBV/Pre9
         pRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455461; x=1796060261;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZHBxkIsMI/Qp+ucOhJHKVnTKpB2RmQ5oFbvkHFx1xQ=;
        b=rNmwk3CtdrcoOtP9B8BECHm4d5NQumruQD5pjnH3qm4WOXwR6IfLVsjGxUw4rysHqv
         aUfuOFe0AIY4c001nalm8LIS4/uXZo7ypNE+nOi6sh2lL6DC6n4A8SvaMO0+pApCx12s
         cK+tA4vOw4/AdqA4Byz+AMaAScVD1coUrALleKr9G5khRiLHgLEWskjzadfVHwiNB3W2
         CaFzECHq54znLu8DvxQZ4NVOrtNyoTZ/j9zA93gC0ePjswW+xRtG7iEkHtdz7E/FiBw/
         OsqecBGYx3iGqi6TazjSIQsiamjVKtkv8h6jPdQXM/XoqZIMpHDeoBtgfiIcGOZnnIjV
         tucQ==
X-Forwarded-Encrypted: i=1; AL+hErFAghTkLMfxz8AOWg6cS2+q9tMqTvUX/z7nB39Etsxtp5nRRdVHX5UayAzJ2SvI/xPoV0VbYw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/MLDXOJm3OnZUyMNACL3WWVrR/Qf6GCxgYRfxlZoqFQZ7aqztb
	DFU7DR1snymDd6lO3t9Ccs5Wzod0TSa/8V+08ZTjhfq1a+RJwEnQrSr6
X-Gm-Gg: AZFdTZcvl3ehpEYQHfZDn5HdpIu3G7Ofw8pQpHjsJn64zpAFpR+noQkznC2dTsGbpqA
	RdlJN5txWkRc+R+43HC3rb75IVIvHcqLZmQuPV1lJ/+opBt4Cj+gB/2WF+ga4/raojgWO3Bklwi
	EzDLXgXznsW9Bi1ior91vu+l/9WI3LA1DpwzgZUYvLx/8eUbq9ePRtw4FlbmGxn1X5nvTZ9HSLP
	VAOvFmzamQ2A5/bjqCDof8krmqfnYwU3azV+SRUJhsghtgm+yc38geFRMyeliC5oVNo1IjkhCcL
	kC4wl2NSx9sthMlu90sPdsWJO9T365v0E0U5PvSCGs6T1UQsoumlKcnl2oTSiXa7Z2KQHT4YZ45
	10RQL+hcQ/XBurOoxI4c6isqx3xiEqKmeGOrrerxhrbIZ09N/rd1/EVf7YgfFp+3H2DP4EjiPph
	7vZQ1WS7jtWPQiUZ0oaUbxEnZwnNLUtfchwPewTV9jeu1sqTEjfc+Fud4csEk06bC9H2meMSUnd
	JApd/WdE2kiGQwl67NVbvTfIK9K+yQ/8sXVQIg27D5J8im5wnmEWBecLJtY4eu/ervEc1uYLCZG
	6YoHN5afXlJqz1uKSm6xj6Fhr49NklgRnCzWtw1+EpeseFfKqgkzQV1/sHYmZyg6zOO1isyOuYq
	ESMLx+wjuCCwQGqMSJrf/FdNm3t1HlHjLGo2e1O2GDwTLIDcP3KDijEAoCFE2cg==
X-Received: by 2002:a05:693c:87d0:10b0:386:b823:d6c0 with SMTP id 5a478bee46e88-386b823dab0mr1978021eec.4.1795455460957;
        Mon, 23 Nov 2026 09:37:40 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:37:40 -0800 (PST)
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
Subject: Re: [PATCH 17/27] Docs/mm/damon/design: update for report_made
 probe filter type
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256508.4.18069260923134156169.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-mm@kvack.org, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261121210013.130397-18-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-18-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:01 -0800 SJ Park wrote:

> Update DAMON design document for the newly added data attribute report
> existence type probe filter.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
