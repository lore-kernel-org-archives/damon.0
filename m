Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435432;
	b=gZssUx7mYyA/Nk1gDD3IT83K1oN/bxE+bAHKes1ddbO+joOvwSj/PnDnH9eIptY6xx5m
	 slXF8cy+YK2JwRCc9yEftlHbkbSfJ7OKS1WukZ8BOEBDSb2TnWIc1+Hs31ZDho09WAMt+
	 BJys6ilkcc2O79R39/iZn8IOMy9wJ0FtwPb03wEQ7qLvk1zfLw9PsSaPGX8raTg5o2wPs
	 BAueoLKcmqlFrNOqSVSLpBF6mB8Ug9OLinTjzuygepO4JmaorshSiLDQhVisDt3wiF+GQ
	 JUkRGC2F87FqLc/VXGSnDBvEW+GqgCbLzQ0rLkAU9Rqj6OPwi8WKfWU/nTGKeNh2tqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4yKvLgZfFwS1iVko5Zbm10jwWwy25iLk7A9hAJwSx/E=;
	b=XYTYLx6ln5qfrvW1osOgQCn3+VVwjDy9SxHEwn0yp9+8VLaYcWx/UfdGHyCWKWgZHaCo
	 X8ZHYo30/uV7v2FmW3uJtefzFWnuvQw74gAo8PM1LiPBSQ0e22svjqeiYe3UpQwDOPiVv
	 Qzp5yU8ZgrkWEvo8+Gq0qQliFAFEEOFwJ0cR87v88pn3/4pXG2CL746zS6VeB2admqrUA
	 HeTOYgZa7CnJCITjerDSYwAwBoplp8/VWDMDEhAh/G19Qfz6um2pWrZs7EakxO4V8xjC/
	 d3FYzEfh4lsREGyPD4TyOeJd+6kHsad0rSV0wMjBb0kIEGPe9F9tBFcMu3QcAt7jOJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgP9Kg8W;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F1606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C35F1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgP9Kg8W
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b4a93d0814so284954a91.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435431; x=1796040231; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yKvLgZfFwS1iVko5Zbm10jwWwy25iLk7A9hAJwSx/E=;
        b=JgP9Kg8WIEhs1ZmtyMkP9Xi5g4rlKdTPUC+n2Vf3yA1yQGG8P2+siDy55a6uCFteVs
         MXmn2VFD7y6g1MtZbiNo9E4/WqiwboNMzd7ooxAtE/2EXM8xJZLika28yR6rkCXvZFWy
         Wuh1QiZcrk2+D+AtkJvGQBmwHb0DAo7BW7xDwIa3w/HcuFfFsl9Jy3Lrz+9R3VErGgCf
         k268EEPXquv93GXWBT3vuD/AOnG8JrOOLB4JszLWDNi80IyVTBbPqEUVn8x4qKxwXNOD
         TDse8n7cHfvtCdgRu5i3il/2PCj9A9Nm3kTNrzTQR6gzqDYLpT9MKmpApmvDyIZ4nIrG
         n6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435431; x=1796040231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yKvLgZfFwS1iVko5Zbm10jwWwy25iLk7A9hAJwSx/E=;
        b=Pgnuy3Kg3R7k0625GycTrekcxpF2xq2F2ZgqDMpjLqfKp0xb7yZj+kfA0cJZpdwKbs
         thIwS2Z6FBbLCQrt82RusY+7j+B6JcGCwqLnEDXXj/pIxIDsG3y1tIJRZx2/bb5H5Acg
         Eo6FRXcqF+SagaSUD3KO+4tNHw3lIt2ayzTxKfuFWQTWirt+P3Lt1FXOBGlAzhQawE9Y
         upBaaXvJya5LjFfGd3mO54LpZb/UOOgsy9b0TcFzX1QNoL0HrJDTLFxZsXdDPon7b1uX
         GvopY0ig0XuE6Gp6AW0LZL5QjUanQoW+8/kHjxCYetZxPniLP/4QQY0Qt23df1sG5cap
         fl9g==
X-Forwarded-Encrypted: i=1; AL+hErHTFfKcIfWjQMuHb9YHuAcULY56mlqKqVoq7AX06V5i5yMG7T8wZeInKvV7IM/oxWDqvk3Zug==@lists.linux.dev
X-Gm-Message-State: APuU4Z8AmR3qvLAiG6RqgI1KWST1pPx/kEct2EPTKS9sBemg9SxcAkmV
	xa6oGHyqRyMyRE8G3Z1qjBanA5LZpv7HA+z2Ht5UYJcw5F8a7Wi36Cpo
X-Gm-Gg: AZFdTZe+bb7ZIKV3o4/JDcSxLB3c9V521026qlvmTkBgZwWNebXX98G2fNmdxVCX/zf
	5EFs4ZIT9koeI5KWzndVvu80RGE8FyjxObo8+lVpkHs0E10Xte5zLMzqf5SZ9WMYl5L1uIxv407
	c3yHkfHfWXmF23Dw8BJkIa0dLimID4mHG2JtfnS2GfUZQ343RvuYu4jSADfLBOlOluoQ3rsxfNZ
	yei8eh4UWPbtgUh7xx6XKZN7qkqsM7WdqajrN7uvAjC5SibIfCRCaZWM5e237tZDGKUJyDz4hhM
	aujQ0Hvy6wuSvlP97PgShNOF9T1U3Q5E6svHSc7VrqnPmd8obgBhwUO9Pnpr2PmoeCNNUcOX4Tb
	SdtFJge88DTXsPk3egcThkxv9E9zZJ0nd9OP+zEnH1kQ6+ePxNQIlix3tQprLY53CMjCCufCEAz
	l5Wrxk8zTRLd+C7CSmGmJJa6KS3uNCJHsTlqDU9zf4cX9Vvh7i03bSZUiccafOSFY0oPUGnwWy7
	INmFkun6daBT/2JolvJLpsqZPQm3n8Z1Snvl3GxSf3g9wxZd0QG2lzt2MPTRAyyNg/in/LO4RDn
	pvAq6WAJu8VPQADpnXcXBlhfBa2dRNefmjPUjAG3R0Pwj2tK7kZ/rNG3IfV0KtoFtG4sHA==
X-Received: by 2002:a17:90b:57cc:b0:3b4:f23:43f8 with SMTP id 98e67ed59e1d1-3b41c908fa4mr9358128a91.20.1795435430862;
        Mon, 23 Nov 2026 04:03:50 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm30450974c88.6.2026.11.23.04.03.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:03:50 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 24/27] selftests/damon/sysfs.sh: add basic tests for admin/reports/
Date: Mon, 23 Nov 2026 20:03:33 +0800
Message-ID: <20261123120340.9486-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-25-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-25-sj@kernel.org>
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

On Sat, 21 Nov 2026 13:00:08 -0800 SJ Park <sj@kernel.org> wrote:

> Update sysfs.sh DAMON selftest to cover basic file operations for the
> sysfs files under the admin/reports/ directory.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
