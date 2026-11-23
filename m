Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435287;
	b=RuwaF142LjPXghbbLlYLPqpCMZ1ui2Xj40piVEa4iyjP+56d86T/JIGze4oxZyxrZph2
	 uGlrIWQXADhDSnr1j/3+VvuZfpe0DZvMHdEV4p2qxIE4+m1FfUJ0jSKbcrwTWuFAH/6rr
	 Xt8IGA7sOtFkoaclelnOY1VFoOfs2eBhqEYHbuWf753mF1LTMhemT6BfpputU5urnU75g
	 9CSlclkLi9xFF2p2LncrkDuNFm/Cm3Chz/1YF/D4AAtkMgzQa558nxns6s8oiUgAo/40O
	 Om39pTyNYGZAgDyYgJ0IVdtLyZc9i+qqYMehv/xu28KCOYpvaR+ILW0Sa/AAIaz3J3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4hPeBJUuX3mm7LtpJ/KyVL61wmehbfT/UZq+ryhG2LQ=;
	b=k52oAfNVUIAay7+KgtB7cOEBUgIpJbOmlA1lWjpbyfJlpPmj6x2U1lvD/57X5lDaq1YR
	 Wvq9c1GhpZzIBBe/GC7yhZ8/L5xojGEBItkaWxWvjaF5MIMrfpT8lc/ZjJYRL8omIEZkK
	 mWVJVREzil9ktzrB5EFqJsV0vHm58Hefplu4JgrIe3PU9K6K676KZaNyGrmTRIyR7FxCu
	 fIlhJkMtK48/T1lxSWkBr/83q6oj9gFcp+g0uhyOyK4lcdNw/wIkt2oRyuRBka/CQFrWN
	 7aVr3LhPWJIyaXtGmijpze74BREZ2QMkjXjtQFgXqT+aqeuPez384cdpSfFr5XA0eMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xGxdOgvj;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085E606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1085E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xGxdOgvj
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386ab9ab619so2035616eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435286; x=1796040086; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hPeBJUuX3mm7LtpJ/KyVL61wmehbfT/UZq+ryhG2LQ=;
        b=xGxdOgvjSqUHLBN1JWILq9khHaSbEUH5cgBeFwRM+dHUs5ExWjt5bkj8RgzPSsN0q+
         jeDMjQgY4j6XCYufd2ZNALSaJrnaTQSaGqz/2e0oRe+9IbaGBlZJT0DbyqlXMQjwAvI2
         +Ia9hoiXD2q47zJJ5sss67vJEZ6t0K7JRSBsL7VdD1WlhHsFf02OeU8TVAT+HAzkxD98
         xnnMQGixsnYHcK1BAbtivtnng1jB34rZO8Hi3myte2DZl+IY3mUMuyLhwLESo1qODLYC
         UX3afm0JwB/nraKxr5QG5AbGP1fA/53szFkCRLnGReZEtB89yIFVDjDA42ZZCTI4rfzA
         kWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435286; x=1796040086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4hPeBJUuX3mm7LtpJ/KyVL61wmehbfT/UZq+ryhG2LQ=;
        b=hrDq8Du+mnUDwlTD0Ul3kJoneMReG9pYZ2I5YBfLBudRKPSqY7Avrv7N9xoKEcbuca
         mVBIVYAdCymjl9Bqs+uYZYmOQaKIPgXJMCKKIyuI/0oiBe9OUpx5xkekghfuT0O8T21t
         q/+mn50zhzfn/JIgNSMJMOTEhQxuXlykDNhegBZ0SBNoViLtoeeTL/kbfMOa3S8iBj+6
         okLDowQaeF/eopZ8pKEfAYExRNEeKrM1YY8Arkrgb+ZLIjOxYkQ25LCNfKzZ+aoKiS3M
         J9xSEj1oVwyFpGJOwfi5cik51Z2QaZgroKdokcSy7OcUDJWfszPJp4goG4+v+W3S8YgX
         QhCw==
X-Forwarded-Encrypted: i=1; AL+hErHP8QebsisM/NmrsvAnR6oi/lb49HPrCtgziMGy2zJojvLBuwtZEWtkFErQoV7CQsA11cUORw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8eKpJDHYvybW48iHxi8cgqTppNws4gLqCU9PEgMiKwVTciy3zq
	ZNMMjbVQ1vWhgE2no/TbG1Exexq4XqxgquddptBtQP/OHmznkeUZJt3i
X-Gm-Gg: AZFdTZfBGmQ3eOlnh+Te7PFbYsa85n1mHaWtWxBy5NkJHHS0UqdobRPbUUDqKIVS/j3
	4/PgH6vbHLbmUqXv+qnZrfK8hHdPrJgpXQlVdopDHg30bW1wzspHwkoALfnA/Rzj6FItQSJAYY9
	6JkIn7tmhMJaBXw2/3h3rGu4sN5dVw47g265zAB9eXc546Wcc98E1nAeIjRv7PfmEDF4BU1faV+
	B4HbwaAEnSIKTbrNE1xK6EdiajQ68JFQYvCdlYAaO9+bGlilTjEasQg5IEtgEHL5yvHNlgvV8Lb
	MTs4FZLb957IQ10fpmAfBQMXTJ/dFrTZ09ZHsazKK9tCSuJXCMbdWBKhPJj4OqmEU1tkhxxmAUL
	z4Sq4mb7Ep2rbFcoytAPlm2M4Z2w/iC2vRp0wBJ7W2XsOmgH8eFs2BeGbRravKSb4t6lfkFMoGq
	3chuLNOTly8ei6r2yJbvoDxOP5me3ldkYMr8iFTVsfSlHJ9ggecG05cje5PylC2XxUFcIcuOSQe
	vyIAoLeJ/cglDeervbCulQqG1tlez21O+92jnwZcPwaOCsXkYPOVwCkxhs3Doj+ObKWnC7ZzUDm
	VZPbpiyAk3fGnCEOxcehf6tpYi7y/1Hb6Jbg2KPAXWyGbqN+i5Q7c2zNGzlWxoxEASK4cSAoHAd
	bIx2I3Lp3BMXroA==
X-Received: by 2002:a05:7300:1c17:b0:386:a105:fa66 with SMTP id 5a478bee46e88-386a105fd17mr6612093eec.7.1795435285963;
        Mon, 23 Nov 2026 04:01:25 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm39368063eec.24.2026.11.23.04.01.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:01:25 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 16/27] mm/damon/sysfs: support REPORT_MADE type probe filter setup
Date: Mon, 23 Nov 2026 20:01:08 +0800
Message-ID: <20261123120115.9215-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-17-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-17-sj@kernel.org>
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

On Sat, 21 Nov 2026 13:00:00 -0800 SJ Park <sj@kernel.org> wrote:

> Accept user keyword "report_made" to probe filter type file.  Set the
> damon_filter->type as REPORT_MADE for the input.  Setup
> damon_filter->report_type with the filter_report_type user input.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
