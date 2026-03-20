Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AF2D9EE8
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985055; cv=none; b=Z+/nM2cLfFHfa5TOf5NPgai4CskF4FDivmbLsDPiUSMVFPBUQnd010vPid7RW+FOGEGDAa4jP++46ZB9/NM++gBtCw2/KBOaV3U5U5bkIu9bDsOJOGJ5eGJ/J9+wOdvhOCISKycfQ9M+ahbTptTsxu/GKu7Cv2mQeWKu0TqU13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985055; c=relaxed/simple;
	bh=t7AUkyahrA7jetaNYrGD367jzrlPTnRWAlYOYrOS3To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaNTPK9X8b6OtMH5+yxp4Q59oeJcQXTvL934IFwuI3v47Qp5bDfNdfFll0yy1pkL6r95TPb/Mevun9egAV5yE0Xc06tMVgkOp88D6BrYWrOWb0Get+TiRXjVUevcNqkWtrUMQYtX+IV2cKJIcyVJjZ6z+emFf/97mulUyp4yElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muK6yM35; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muK6yM35"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c648bc907ebso1049711a12.3
        for <damon@lists.linux.dev>; Thu, 19 Mar 2026 22:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773985053; x=1774589853; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7AUkyahrA7jetaNYrGD367jzrlPTnRWAlYOYrOS3To=;
        b=muK6yM35jIXVjVdFp55j0B46TRt0bUrU7MXz1yyP8KbJMluQRmdC2pH58oieQqLUFR
         YGRE5INhqvD5TLdozAZ3yitCUpyRoT0iCagyPR3NZ5113e8MpkQIUJSZdWjnCNkIzH3o
         qXvgU3AwFz6gN5OC/5FIjvDXgWMziWjyvXaZJFWrRjXDGbQyICecW9BTl3wVHgwgpj1V
         KGBxwfUIb9rBR3bICuu6lv5ZtZmZcc+r9rgJmgMIKC7uzRqWzGg+07xTnbAKiAMJdNsV
         ciwBfyo1vxUxJC67LebPu56wrk6QdQJfEDTdgOLdZktU/q/eE7f54m1evnoKfjCvjHCD
         efEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773985053; x=1774589853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7AUkyahrA7jetaNYrGD367jzrlPTnRWAlYOYrOS3To=;
        b=BaFePkBtwVJggjgMg70LWpQjRjHFgU67+HTZn6CK8DpmS04pWfwL2YKBGPU0Cm/ppo
         kw80xRmjt+cQwsWuIW85Z6UeNQQ5JO5c9zP38yljyz4M90fom9P79L4jVBdAc5E8Ao7y
         2TCcP4X6TKtwmBU/nVU/nxlvaQXr8WXy+Sw405A+4tOUfSH56hGHj3QgU5RXlbUR5LdB
         uHf/pUT/ww1bIATPc55Q0wBCog334kw8ZPxv0EUUZc9X2EUTIZJUY+Kma6DnkskkB/pP
         4IMNwJIaFcmcsTuUOaAoOPRi+08G1jM/fLWg3I08PEeFrOzMf1pIhpN9SJUK2OsqPpxX
         Ig3A==
X-Forwarded-Encrypted: i=1; AJvYcCVtHKR2K2yhnDwC2jEKBJFNcn1h0xh9l+mteDJiqsbHygMbwvcP5N8AE5mwW+fRGjCgsqwIxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrWWmq/XJWtFv4S9ZtR2TizcU/4kLBPA/NT1Ovsq+SOgGWdjFf
	PyTPilbH7CRl8YYwAsHL7WPGcbsRVl5wnrhtC6HTKVj7qG6/V3gIIMz8
X-Gm-Gg: ATEYQzz79EEga909rI3b1pr5oaENqn73Kt1fN1hhQo6IBQR/Zo1R6SwsZ+7G+smHBUr
	NHZ+X7fmcoZ9Qcn7AFLpgVZA8PTTCih8E/YRwlo5ozOiep26ey0YGNbE6nM1Cx0dw8m+FFjptUu
	UYZ/NjjMsfHUkxGfqzcdRzAfq8paFLmPzAlu8MKEmc0MpL+N7nwApRjHpZDSto1UwFj733yVTIw
	QIcq1B9LTk4LgviM3REpeJ6IgKfgX9l7qv/0h17GMFpApCCmiseXXDkg6/Y1WNSpT300anzYATC
	H43U+8hEidkFi6rXQh/PVJs+BW/mRtrW51sv3UH6PZgjzPJH+eiv47tQJhtD8KRbTlvsnJzN+ph
	EsJaHj0pN4DX6OkyQd0G37O++i+MED/5Ga8ZXAHEy6lj7UILWsKuchVWEhG3mvb2TYPZ6A5GIAv
	7MZaCJH5mqdjcWpIx6wpSiIHJDGOc8lIqj5gJtMLayMxBxx6RtQRoXEOqwi8To4g==
X-Received: by 2002:a17:902:e850:b0:2b0:58a8:5f9b with SMTP id d9443c01a7336-2b0827de53fmr18104835ad.49.1773985053460;
        Thu, 19 Mar 2026 22:37:33 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354bcf0sm10226655ad.33.2026.03.19.22.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:37:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] Docs/mm/damon: document min_nr_regions constraint and rationale
Date: Fri, 20 Mar 2026 13:37:28 +0800
Message-ID: <20260320053728.213664-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320052428.213230-1-aethernet65535@gmail.com>
References: <20260320052428.213230-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current DAMON implementation requires 'min_nr_regions' to be at
least 3. However, this constraint is not explicitly documented in the
admin-guide documents, nor is its design rationale explained in the
design document.

Add a section in design.rst to explain the rationale: the virtual
address space monitoring design needs to handle at least three regions
to accommodate two large unmapped areas. While this is specific to
'vaddr', DAMON currently enforces it across all operation sets for
consistency.

Also update reclaim.rst and lru_sort.rst by adding cross-references to
this constraint at the end of their respective parameter description or
usage sections, ensuring users are aware of the lower bound.

This change is motivated from a recent discussion [1].

[1] https://lore.kernel.org/damon/20260319151528.86490-1-sj@kernel.org/T/#t
