Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AA368
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:35:07 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id t17so2670332pjo.3
        for <damon@lists.linux.dev>; Thu, 08 Dec 2022 12:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxoZSb+LSg2Sr/OdadIfRMcj1fpcuMZctN0ht3p2zD4=;
        b=VwCLLnMeB3k+m93uzv1eq29GbH6lHGER8I1wurF0B4Ax5fHnR3DiQNpHMpGfvnQfDu
         nZmLmXIyRUnA3l2X/+56gt3ZWzqD9PYZjPg1KXKw6WQma7pTMKUxQinuq+mdDLgBkGkC
         WXAqILax3018nRSDwH4AurHrjYoJUmirxagXs3LOXrnSe8Oh81i+WL8IELBXBUnBxyVB
         qABu4Lt3o4Izbyi/FqvcONlR5+wY2gSQiveHWVQHRZIfAHROSQ/kr3nHXUL8/bR+TjxD
         Sy0Kv5Vt3kDsNE4EIrEzNiQWYtTJ8i+k8vZzt/6gKS5hCKt6zCJ338IdAS7JR2e1PjWH
         sRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxoZSb+LSg2Sr/OdadIfRMcj1fpcuMZctN0ht3p2zD4=;
        b=lQPWV/6jRNzP0Lo/aPy+C1+y5BBWEuwTMQCP6uPHWPBBAAX2ehBI/wJqUYJoJpyTWz
         C6HEPOKQWhULu1LjLoMJQfOJxGNoI52elZ7u0sze3jQdVoSiR7uy4c6ynbND6GfeVQWL
         1sEJPwcJ08gFVXmBKMlal1kvrtBqYWjAt/xG40ngBSVA8Y+kNJKWELGpDoQoVUb1MAoe
         +7rwojS/ziz51wHDwLwF7N0/2IxFxlYSKUK0tzWsu3mc9IuqyHgbkK4++1350XcpsaJB
         kpzZL2mKnyd6PT4HuJWbBLtOEOEj9dV/gO2c3x2OTxZnxo4lSj1YwfZRX/D65esifhu7
         FUeg==
X-Gm-Message-State: ANoB5pkJ6IAVrez/ve3BMDphPkCv2K0+XRQ/IwivyXBe/Yj21sydKz8s
	D5VXyks1rqq6iXNYzAtm7sM=
X-Google-Smtp-Source: AA0mqf4k72/AHpv1DnErQTrKu22mRMb4TU2PdaN2wkHpDZPOhQPVGlP8yF/zfmzlkzsnX00BTjSjMg==
X-Received: by 2002:a17:902:c94d:b0:189:b36a:5448 with SMTP id i13-20020a170902c94d00b00189b36a5448mr4682294pla.44.1670531706836;
        Thu, 08 Dec 2022 12:35:06 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:06 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 0/4] Convert deactivate_page() to folio_deactivate()
Date: Thu,  8 Dec 2022 12:34:59 -0800
Message-Id: <20221208203503.20665-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deactivate_page() has already been converted to use folios. This patch
series modifies the callers of deactivate_page() to use folios. It also
introduces vm_normal_folio() to assist with folio conversions, and
converts deactivate_page() to folio_deactivate() which takes in a folio.

---
v3:
  Introduce vm_normal_folio() wrapper function to return a folio
  Fix madvise missing folio_mapcount()

v2:
  Fix a compilation issue
  Some minor rewording of comments/descriptions

Vishal Moola (Oracle) (4):
  mm/memory: Add vm_normal_folio()
  madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
  mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
  mm/swap: Convert deactivate_page() to folio_deactivate()

 include/linux/mm.h   |  2 +
 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     | 11 ++++--
 mm/madvise.c         | 92 ++++++++++++++++++++++----------------------
 mm/memory.c          | 10 +++++
 mm/swap.c            | 14 +++----
 6 files changed, 72 insertions(+), 59 deletions(-)

-- 
2.38.1

