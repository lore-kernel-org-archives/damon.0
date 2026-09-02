Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790E344D8C
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358970; cv=none; b=cZ8tr4yO9rtkm9v5lhLzvUuP/0VYsJrdhp4hHlSIbMPPv9Tp6lOhCE60W34NXyB6fCEJI71IqlgcexOHnSRjO9kpPH+3TfZn52BfX0geGlJThDk/JY2kTT1KrCoIrEZI9KcbJ69rUTilzmCJrxIStQVVeaXd3oegRZvVReh9C18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358970; c=relaxed/simple;
	bh=kHWwMrEotM6IrRJpcqSUfyhD0sPiyKGP+EIxUzLpGxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B41MAIDrWn+hpXw3CH0FhXkLQh/ykt7Vfrl1zXI3eMZPBT3ObiWAnRb18gXJE/S0OCtuFOJBLRoTAkAy8n/nQ3cSGDisSdvzr8ZOQmuTdNGySmaLbEG+SNNKrBk7I56gH4sb29sfk1MIhlW7bBEjhBb2FI001UHDaOzTGXDVfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVVYO2Q3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVVYO2Q3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d91518a63fso9712065ad.0
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788358968; x=1788963768; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xhg4nFUTwBRfkzvOZ3lYhulq3dN/Jpsw7Gc9lSLlRQY=;
        b=XVVYO2Q3TQj810TBZ5wK1WCLjFL4z7DemYSSIth4q9EWDsFF7Mlu1pZ+CB04nah+aX
         vkPaQwYX3fKn/ypkyGRr1V8u8d4WmC7XfwZh77LIhy46rx1ttW//isbV75AWGpESKiJv
         VsFh8BMcgyf/xwY0eCbBpX1XVj8DDMpt1dXaRfTrWM89y7YpetQ85Q+20Y0gnH1KMREz
         gAw7HT1mRiO/aYr/UHjnmNMqMJWBNn3SvL0Ef25Kf5H0LX2SSKK6vl8A379fUViAaNM7
         WqrdI9uAcAvkH8KfcboG0T9W0ahaqG8qOy99s79WYOP94hacBLMP7S9RdaGi39IQM2sB
         A8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358968; x=1788963768;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhg4nFUTwBRfkzvOZ3lYhulq3dN/Jpsw7Gc9lSLlRQY=;
        b=MtlOwXg0vEtsxkcGwHK8XGJ6dgJ3BeeO1wkm6ldpdIHToHHmwQNL7JBhEpUSTRW46W
         QfQxl+PJwUeLg49GT88iK1uaOorFdni5g+NWrcHuXedrnkK/G2IYq1JqU5tdQzBJ2hG/
         5dU8IQNNnFToO3YezOfJrmGagL3LRSwo86It6AkSMzxpnOUOPcnYM7ZHavwcru1r1yRr
         H0LVj14V49Y31FyobhVFdIBTccTFYBI9rEeDdwPP1O38s5JJD2FxENEW0rzYn5bN2EL6
         TBwUl30evx1eR2HQEvmA+ish+RSP+phHEzogSiaJRBnZ5Grs/OgyokA4OmwSAmBka8yx
         ICQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/CL+2smlLirev2Cur2oZpghX4mduui1tLTrIuSke8BaPo81Y4oseqFPBftA5vRleiMOT5Nw==@lists.linux.dev
X-Gm-Message-State: AFuF++lD53zKJpdtnzm2Ilgl1HvPWpCBdRY5xydT1cjsJu69HsWBqctY
	hlh7Re5VkVBcAETyDxd2bySCMZMNM8d0mcwLnwSAAJH8IXetdqIbkmEs
X-Gm-Gg: AR+sD11VCMPa+iktJWddLYlWWR7vcHlHIOmX+Mxe15hHmG/4wLEaHAQyNTF9xCqizcH
	DrY2uYoZbCaPtx/+sQLZqc3j8ntjX3y1HQ2joUDPp2ZI2PugyCAVaDgyqLi5EYleHFzA1VN8OzG
	LE39RymGRnL1pd46OMsYfwFUVO6b4TukTNbBYlod47WmEQJX+sdrb4ZqC9L1Z+G3+VtijYiDdxq
	U88eZgnZ0tB5+qsfMejvNAmKOloJl3IRL4PBBYKA3/Bq6hJzfc6psBAKeVV5UXPZA5wqpIVSCRL
	xyMxTIn1YhFJlKZ9C/y+X8l1YH69JQOBs9N9u1ivk67EGGOemoW4b28h1uuIHDSQAkgC6OcTo3p
	0zB601ipCeEXqYSvXM0TqGCOgKyOszTG7TlPO4yuqKn1X/oiAW2XKrP2yfBJvYCXoQKIWToXv6k
	Wr0GUHiRTUqFetxFiineCCusS5jsXk+QxyKabF/O5Cv/M0FtalpDV/ICan3dkqBRzfchjLAegy9
	i6GjzA/Dc0SMUfj
X-Received: by 2002:a17:902:d491:b0:2d9:3636:d01a with SMTP id d9443c01a7336-2daec74e5e3mr70183145ad.15.1788358968023;
        Wed, 02 Sep 2026 07:22:48 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd383b36sm13853485ad.25.2026.09.02.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:22:47 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 22:22:31 +0800
Message-ID: <20260902142254.5328-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902141001.86733-1-sj@kernel.org>
References: <20260902141001.86733-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > When setting goal_tuner to 'temporal', if the goal is achieved,
> > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > will always return true, even if no regions have been tried to apply at
> > all.  This causes qt_exceeds to increase unexpectedly.
> 
> To me, this looks logically correct.  Could this cause any user issue?

Yes, I think this might cause unnecessary confusion for users, at least
it did for me.

I set quota_ms to 0 and set the target_metric for the quota goal to
user_input (i.e., MemAvailable).  In my use case, this caused
esz_bp to be 0 most of the time.  Also, because the quota->ms clamp
was missing, esz wasn’t set to min_region_sz, it was actually set to
0.

As a result, nr_tried is 0 (because damos_quota_is_full() in
damon_do_apply_scheme() always returns true), but qt_exceeds
increments once per second (likely because reset_interval_ms defaults
to 1000ms / 1s).

Best regards,
Rui Yan
