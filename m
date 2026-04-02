Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2232DEA6B
	for <damon@lists.linux.dev>; Thu,  2 Apr 2026 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113736; cv=none; b=UxiIk3YCZwuhB3D7/0LyfGCQxmipC7LZO/6yxGt6KGKaG3+Q7O4PyeKKdpJmD+Zd2UTMKRD/pBJVpHK4TxUqYc4cjbcjIAeiLZBCGm+4auO0rH6MEgyF+eB+Hp40JD6HAPJ6G7SeYkBb1Ttzj1eEYy6jSHvuN9sx0kSDIPmHWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113736; c=relaxed/simple;
	bh=iyHjtoNEHhZyVoW45/z3myeOX1peGCj3SM45rV54Mbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRLtPblE1Qvvr8VttysqVaOM2WHYIfSJdL7nQ7rQ1gDB9Qm4PY7GPyF65fiZsX+j7jk8HfMqkAR2LKsVE8hH81AeBhD4bTNpck3MR1ZqegnGKmy5COb9quNdLNcQXIBkmxCpBb1kcrxB0WNv5XkwULH9+2uyR2+QxSVMzaT1DmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbZui0ST; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbZui0ST"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9f316d68so1956975ad.2
        for <damon@lists.linux.dev>; Thu, 02 Apr 2026 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113734; x=1775718534; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXqVqKsO/44+sf0WqfVuWAIy8twwlZ1ww6xUKeKYgIs=;
        b=ZbZui0STB9II6LZG3rSwEBs0XZ7wanDoWPf3Wokpky8pSZejpwuAFINIMETLVevUvw
         ZMOW0ES74yprQzCtwUAjdDTLWXAoAG+1OfOeGP85lmkx4Ts+Dz4lfNwF9Zwd6wIBhcaK
         PQQ1XLbSYcIOvvllhmlUP2ljQvsGeEiJnNs8qMd1pNSC2gAJf6Eko8mCHlR4BpLTkYoI
         PKpnQ7gtJ6biy3IsenyKcvNfS2TKayqy0S2hLHMmE6S+N+CF1b3VYLKrJWoEhFKoDsZE
         9w/+/e4kAMQEexBO4fFFkZrndc0kGd+tjk67WZV1QKQMKpc6ZZRAjWHFMlUkn7uEBiNg
         3/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113734; x=1775718534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXqVqKsO/44+sf0WqfVuWAIy8twwlZ1ww6xUKeKYgIs=;
        b=K9GfRqeISL6xvIqXW8noeQMRcZ072GZdIxmG0+QIJbl++d/dxrmNzF9MpUclgAf5iX
         0twv8S49zMJJmV7LpSYUCwvabQPxYRRhR6F77uVw1kVi7YwYYyWwxJTuExI0AeZ2YbWU
         UPt3gUwwC8kAlZswsYP5ZADM9+JgbuB7xEDQTDjvdcUMA8+ITNhtKifSLjTZ0pdNCSZi
         dQqW0NiMmIPvf7PgwLhW9/77jmVjDyjvJcfQSnZldb50P3qt8YZjLCYQagJOxtcVK+Gq
         4v7QRqoozpXz8z4ti4Jk08Yje/U543KO9KZ/OEOaVnTjze6Z0MHxw6h4/sTCV2cHw3k1
         Q0xw==
X-Gm-Message-State: AOJu0YyaYUYwX3L4lgpoat76hoPdJsvqR/qKZPX/YuKpcIo9LhwlSeRo
	wtIt+szMEKFAJuA6k7tVtp9J4PexoyvXt3qSetnB3dxYDWRVQrqFy64TeJPxbQ==
X-Gm-Gg: AeBDiev57JNfyvsqLHjMWOH69HzXf7MdiWtEGuxR8rTfP5yoQ1VoAPuYZzavZH/W33x
	CRK1jhRFX0B0O2F5wr9pAHMK7z1rCceu0TUl32svF+ZREUn/CXpa4RorwvlH/B9pvfEN4upghua
	X/EINVKGdH7IR6dy92MPjE3FItRqkVa/AZwpoG4NaDxv6WbKmXpfhm3EC6sL5fr/tLmI2rUciJM
	Lbxy65GvrzpK0NG+GUdgPqVRE8u4Ogj7fP8GeaILmXCrFRaMv0z2GII7/eLgsSvB6wTOlp5uEvg
	EX+w+JlegtE0L897uLxRv6DHIt2ncAW5XsZFS5VDrIQ+fI3F0MEeHWDQs6id+Ln/32d516QsU+v
	hmfO7WF3UKP8i7cjd5UdRpiFF9enU+T/nn40WUAaD8O2o6e+3GKsajpJbsgo7l17J4VsLNvXttR
	naD3TSTItHFDv0pdpVFIRDGNKep7KsSKc5R7XUNFcCrUIA1kk0HY4=
X-Received: by 2002:a17:903:2f03:b0:2b2:42f8:1a4b with SMTP id d9443c01a7336-2b269c3f6ffmr63223295ad.27.1775113734366;
        Thu, 02 Apr 2026 00:08:54 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm20173295ad.29.2026.04.02.00.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:08:54 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH v2] mm/damon: validate min_region_size to be power of 2
Date: Thu,  2 Apr 2026 15:08:51 +0800
Message-ID: <20260402070851.27382-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402053756.26606-1-aethernet65535@gmail.com>
References: <20260402053756.26606-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- [PATCH v2] mm/damon: validate min_region_size to be power of 2
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260402053756.26606-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
