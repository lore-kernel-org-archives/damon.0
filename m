Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224068F4B
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 23:01:57 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso3191722pjh.1
        for <damon@lists.linux.dev>; Wed, 07 Dec 2022 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M7aDOH/qGCjs9lVwYHlVEwpsAApNAGVOZKD3ahzUuQ=;
        b=NOZ9lRCAQZP8wewc5DewcyWHlye7Pd1FmMImEx2GCbB+gZkla2ba5JURxFy6LaQnj9
         QRy1Jh6VQHRInet+vF3UptPq7mT6aCspNbCfXqtFiEWpgTk/jyYUoUF09jz9cOdOu/KG
         ql72FNYp+LJy97RhxhvASR5P1cNDr2aw3JDkb98OT0QZmQ6uKSA3H4v1PpsmOB2zcMBi
         FkwoYUb64Viv6SHIZFiwSI9YSuCiKOvK9Z1Z3HnAI59cqcWdGBd26gRi6Ssr8XUukIwC
         Qs+k0N/LMU9+OSMQBrj0o9AxDbRoy8fMqfIFYF2uQPPKZ5llIqtCyw8rw073UUQjAPPE
         ABJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M7aDOH/qGCjs9lVwYHlVEwpsAApNAGVOZKD3ahzUuQ=;
        b=G/Pr9IboG1asWTZn/MxDI9uYpubuB+oEKluvKJx5JXwSLOFqcluMmXCaBMcLyznvL/
         Uqe5NBfQzl/QC2Fjc+xjau3uLODdIH/quqKu1FpQQ6kMzsXnWWGdnIC9MqkamQPMDFGe
         EuJ829hg5LKMAE6tuf+hJPz/T+VDkAO7XickHiR2/h6m0IoAVoUE6PCnt47az4row+Ja
         ip+Yf1euTtOfqB1vPAO+2o5PuLnzne0Crcq7pN7lXwCxuCoTtI1vLeOHCT3ptY5E09x5
         O8LOdgxUr0PhTqC18jBGua46c06hWda2EUxKjhJzAC3NNcVhWWnHjNl/bXfgp5re4/w9
         O5Cw==
X-Gm-Message-State: ANoB5pmL2CQR1bRJ6hWxuOOf99vFHuMVF5UyKr4f/yH28WFianQB7dI4
	20/jIojP2fofO+vuL3m4j6g/jswRGyDCeA==
X-Google-Smtp-Source: AA0mqf5ru8h/nOgdCusmzUFw+sibQbgtP6oabpN5X1rY40fSPo9N9qSdlT1MBbf08uscyvrLaGGM1A==
X-Received: by 2002:a17:90a:5184:b0:219:b79d:c2f4 with SMTP id u4-20020a17090a518400b00219b79dc2f4mr1145859pjh.18.1670454116513;
        Wed, 07 Dec 2022 15:01:56 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm5411033pjb.1.2022.12.07.15.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:01:56 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/3] Convert deactivate_page() to deactivate_folio()
Date: Wed,  7 Dec 2022 15:01:49 -0800
Message-Id: <20221207230152.22938-1-vishal.moola@gmail.com>
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
converts deactivate_page() to folio_deactivate() which takes in a folio.

---
v2:
  Fix a compilation issue
  Some minor rewording of comments/descriptions

Vishal Moola (Oracle) (3):
  madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
  mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
  mm/swap: Convert deactivate_page() to folio_deactivate()

 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     | 11 ++++--
 mm/madvise.c         | 88 ++++++++++++++++++++++----------------------
 mm/swap.c            | 14 +++----
 4 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.38.1

