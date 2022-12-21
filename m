Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A528FC
	for <damon@lists.linux.dev>; Wed, 21 Dec 2022 18:09:58 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id v23so11292821pju.3
        for <damon@lists.linux.dev>; Wed, 21 Dec 2022 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yca21srt3jfSdwv9cmVTSEKRbmKmeVKwhiy24VVJrgk=;
        b=DSJOlh0H6jO1fPraClFL4H/mt/WnSL5eSOkqRML/zohANW9YASclvvRuLArC7LygE3
         69S5K4eBQ++zsHnSyQ2gSimwzS8WGl+A2n4pxh15QxZkW7QoqX1n7ZPNCn73roGCVPLY
         CQHjdyeuniToYJ8i0ndIZVvqJ8GQo8YNHba6+zrTEQTmv1n0sSdekDXmzlYzAFZFqhZ0
         SaZxNuSh3D7Ez4dVAorCB3m4HmUxUJKkB9U9AZ/n9a3GIktg1oHRi2rsKDRyyp+US4Kp
         oZWAgjNMowWJn4ge84VDkrM0ANapRf08CxpHxldzmZQz0b5OGD7KSc70oXXX688ZWPRt
         4uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yca21srt3jfSdwv9cmVTSEKRbmKmeVKwhiy24VVJrgk=;
        b=uFBzeFiCJ97VKrvoptUfQJJ6GE9UXTJy6dgSREaym2ELkEu3jl/9A5YUQqpbaBDJDt
         /t8W9KZEhYcxwZ85SP8buE+hBIBr03vnacFc7hX9kT0vWdENJnlM7L2ca0ESGLo7JyZK
         A2PxYUU7E4Y18tq/CMdYhDSMmSgJWch8zAbxjb+Mct1e8RneLMjBcgtVdo0pOHzrWWII
         VkxPfkVU5xCaD3FDNcpzkS528zEz2MIUznGrBHluun9xVU6LcywZo/cEN9TYQg1sbBI9
         36AsEpeBfbKOtkko2huPS/7ehI9QSZyUrHnsvfZnqKW4mxYaJcgTYSlIPcu2wawTX/FB
         LCrg==
X-Gm-Message-State: AFqh2kr4x6h5ANZz1loKJtgOjIOLDp9yc+g5NtMw22b6uIhoi6ZfPY4S
	ghwaW3UoeCGn30x1TCWbSwg=
X-Google-Smtp-Source: AMrXdXt+oepsNuWyWeOO7XR/0jnSM5UBICF9yESwu6cJLSH7Rdfzc7qbutGMcctI/PrXlnxwykdglg==
X-Received: by 2002:a05:6a21:1709:b0:ac:5671:adfa with SMTP id nv9-20020a056a21170900b000ac5671adfamr20123978pzb.18.1671646197796;
        Wed, 21 Dec 2022 10:09:57 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:09:57 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 0/4] Convert deactivate_page() to folio_deactivate()
Date: Wed, 21 Dec 2022 10:08:44 -0800
Message-Id: <20221221180848.20774-1-vishal.moola@gmail.com>
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
v4:
  Rebased onto latest mm-unstable - fixes madvise and damon conflicts

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
 mm/damon/paddr.c     | 14 ++++---
 mm/madvise.c         | 98 ++++++++++++++++++++++----------------------
 mm/memory.c          | 10 +++++
 mm/swap.c            | 14 +++----
 6 files changed, 76 insertions(+), 64 deletions(-)

-- 
2.38.1

