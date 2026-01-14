Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83030146C
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361140; cv=none; b=SwH/7oys8nbaiB5QckI7jBqL9Y2bjgoGfSi0kbbCPpsCOO2oWSJTBuvPOZpc9XrtIbgjODJncyrTgyvpv9GypUZHhmpN3at/0SWe6VEC1e/o71z4SQhay1D71FbIACPSanlPYa9Y7WTxoyNJcrKafEhYK4BvFYxjomMO/FwtpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361140; c=relaxed/simple;
	bh=qeyFFUHOfvOf/Lso0USRbtt36V45laqGZKievGEoTMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeKM0TJEz7NtEuA12dkchxRjOjfGkoQs2PM+iA4N/uGPSn1L67gJIHDoXsPvKTPgXUxk4EUAkTblliCnQIccvSZHw21bvBv9F/crOGKKGHjha4g+/gdtjLKmD0Hl/ej86vw/ImD67HEJbO8QOojlSqUwgwsctjvBdyTsM6U2iN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7uNZmzy; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7uNZmzy"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12332910300so2420793c88.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 19:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768361139; x=1768965939; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbWLobpjJa8xgEi+LiwpClMK13xKffaVB3M347EXltk=;
        b=P7uNZmzyMdBqIy4FmOtu0L6NLIegL4OLipGl/YQ37TENGtl7glU5gHHlLAEaqNy6sJ
         bsYr5Pdid5C5/lOZjvcNagq8pBNkYBe9nZQ5PtlVTcIdNZVu4vrih5L9mA7ij2CklK9X
         NI4xd2CvhhrfE5f6VwNLXhOhyGZxEdpE9mXQECax6uOZHcgkMibydWMCD6sNkHBtCA19
         1gYS5HxCfsS33VViCaUS/5A5S5GMT4VLiLubE5hjDe7sZFAgbaHP6HeHr2lcSH+VNU8N
         0pNpWVmUUQYhOjw6ygzxoblSDluN3yz2o8nH4sAXbd3459onw+cs1XamFXi8a2BrmLP7
         QLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768361139; x=1768965939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbWLobpjJa8xgEi+LiwpClMK13xKffaVB3M347EXltk=;
        b=ibTFnTcoXb3ZG0qUN4P9y5oQwOhWMu4MJcHeMu8eDkE774GWu37tiJAF/Jb81mAZA1
         RGGIJDeBWa3uHtZPZdyPqFD6fFO7opRmVui4xsLMncqi6n3WHoqMqlTmhucCmSkaPoBz
         /172RKMgmyQi5r4LrrjBabRiGilIjUiyGer2ug0LN08FvWN9Juj9imRydPOL54Xj65VA
         monYCkAe4X9PQVRVyvBq40Z1YrNJ4zVpcKqsDaxW2gkMY+/dwK0zVpL9eMZ/sbZPTZbR
         CSlIeRsbd86Ydnj/h5tuhXfqET4Bhwc+80ZDlvwbx4TuxWxMDGFt5rILKiG8l4AukT+w
         CWaA==
X-Forwarded-Encrypted: i=1; AJvYcCVbaTccPD1hHD+7m/NieUCqSZLnEhCk5gBXIBqL/TzpV79S7JR1fm6c+iOxI/S+GiNbkpp32w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFnmaE5hF3+dxAIskhN5ssR0ftVGPvYLgN4MiLgp605N0fk6v8
	aHKZdm/U4yk0eXxJ8Da5p3HtWAx1ScQ/I7pgLaH/6GP89KJZa3cxk73w
X-Gm-Gg: AY/fxX4VwALC8pNx6Rb0wmKM2BNaONpnt37Z6mb0QIIFDz8Q20sCXW2ZslMz016Cd3v
	tbaz55E957iGRueM2QPwALIenlUU76QrbEtJ4RS9hiYj+h862rfl2GCfSjH2YOEUaX12iY/4UNr
	QKgkotPbh/WAlcT/WcuOAr4/cDd0VJJgTeBYgYPrRdS2E5+6fZzE334STsv6kuelAHe07OAMItc
	ULWaflGSIt93tRd2aEwlRgQpF9jQURLpZTaIN8pGqvm2uXtIB45oOW2QN9Fadf1NudafRG0mr7x
	b9Gr1/RopUZc7GZBSW2tQOhAr07LiAoIlAqRuBFp9lGP6W8HzFEcxUUvneTP6+hX4X+pmrt0V/P
	Awn0LrxXYd55vAy2r2VY6WFmNo6fltD7IQmBcScIVERr0ub6vkqRCPu+/SIqEzaglf+R5PpZ50v
	dQ
X-Received: by 2002:a05:701b:2504:b0:11b:ca88:c503 with SMTP id a92af1059eb24-12336a33f69mr1176816c88.3.1768361138641;
        Tue, 13 Jan 2026 19:25:38 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c246sm29706885c88.11.2026.01.13.19.25.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 19:25:38 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@suse.cz,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 07/11] Docs/admin-guide/mm/damon/lru_sort: document filter_young_pages
Date: Wed, 14 Jan 2026 11:25:16 +0800
Message-ID: <20260114032516.83483-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-8-sj@kernel.org>
References: <20260113152717.70459-8-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Document the new DAMON_LRU_SORT parameter, filter_young_pages.  It can
> be used to use page level access re-check for the LRU sorting.

> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: wang lian <lianux.mm@gmail.com>

--
Best Regards,
wang lian
