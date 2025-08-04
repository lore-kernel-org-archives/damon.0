Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241826C3B0
	for <damon@lists.linux.dev>; Mon,  4 Aug 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318320; cv=none; b=bkWo9PY1avUf1clmt/mqmen/+FoflnGHVOUDa45cwDzuy2pJRpdvdVPQV7VcYu1av7IzfgVm3pQCLah1aHfzSZDxucnfQjlGLaUdo9Vlf3GBB3exDO8HT/ecRi6KkNwqUmc5G83pygY6ghhLENhWIqDEIbvpoRzt+NwKaJoQjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318320; c=relaxed/simple;
	bh=kLDiv+xg2lnCMNUgSDXM1iaY1TEpLmDwahJTmHyxR78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xc/NQ4HuehrZamrw6CUxrysjqds3PwPJt58g05xHXsjFjAv01snHDWXMKFqucEM45Dwv7orenAEnTn7DsYNwV+SIaRnRJXQM/2U5BSSMh7cJtMDdIk6oPD6bfEcRfz4pj4uJbrFCB7dFH6uY4QDfFvH5K9d9EVrDlv/rn7QizqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjQLBXmK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjQLBXmK"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31ece02ad92so3659770a91.2
        for <damon@lists.linux.dev>; Mon, 04 Aug 2025 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318317; x=1754923117; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKqsGYjG/1BmdnQ0cztxxQLi7+AdyPlUFMMBGfBbx0k=;
        b=AjQLBXmKh568iNpJVl7DacGURF150zlDS9vhhiw8MnwHJPfqu/8hoVbGnLSeQKj8cU
         G5mir+eu/m1YsMORbs25NN2+ygwpJdX+1KowUGFe7+xH4DzVl0PB0msUN1c+thbKdt8R
         25FL/6JWnlbogoM94ljh0vV7fvpbimdMz6c+sGxZv2Pncpw2HQicrVnh7aGtPag7yJcn
         /b9FaVZIv4+q4uodqif7R9s+1xMxxv10AYKv3kkzTuapznB0Wbc3aytjl5xeuEnlmAzG
         B2W5wqLw5yqo9ByNTGwO3xQqiIfBwzT5h/WGl8M681Wb4PpS7rjTQbmByZ9i+ny+UjNZ
         tFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318317; x=1754923117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKqsGYjG/1BmdnQ0cztxxQLi7+AdyPlUFMMBGfBbx0k=;
        b=HAuklfVQstebvQW1msd/aUubER0NEdq+NdsqR0qqlHvqrWovpqIa1dlGCROEv0/5xM
         aJltR/lnPet/GDhz34kgQFsTFAQFPFMfRaqMKbNwCfgDg7csoDHK+6RnPZx7yW/5n/e9
         j/HMy4YDAAIFlplq/iePZelf5TmpcHhnvOhTDiGmIdOiE1YSU8rO1XuZ8fcp6ghCB/Ye
         Co/4JffXsj+WH/AnOuOLHmkagtf6h7a4Ff2B99X5t3nhWwXsxG7eRdHBHsbS00VZPsmh
         qrXiFwu9DUBY+b5Y1gtoQESDsBrhj2SrTuF9yWI8jKyv1i5quMO8ZiQc8tMXila+oH+i
         o8zA==
X-Gm-Message-State: AOJu0YxSCnr/c8cZVP3pyzaAvP4Xw2sLTjGWcz2MZmgN4IofVwHGInog
	AHel9CEUfdFewKnACnBLcgyINWOIArKeI37wqaByUqTMoLaCuGOAIf8Y
X-Gm-Gg: ASbGncu78uE7fFfMrny2BzTEvWDnnEwC7eVdKRvc7AqkLCSolrfTKb8iyTS5nkJ7v+Z
	NuGWhnNmLHkQucrukrvUs7zOoyQrVvf1eIlrNc2zcF508v4PvzHkKpkHlBRDIdaaentiGRUSYWI
	n8xmXVVtA+TtO6DNOiPKOOK/FmEmNB8WPXNqoZ0T/rvhbDU6pvw1XitdgGVpKBxBavWYYTadHhr
	Mh8eQ0TQe7jJ1Nsv9aA837RheuB8Id8EbzqN3Ybp5p+dFGrZogmgNKOfDmW8+iaHNQT4wY5ajAM
	cZU8TbnAcCB+6+4lxGznmWpvEBZcqtUer5ObHzUy6noPhweEHbc374cYm4RZ+blJdevItD/pfY1
	340pDe6a+CZ6RKPsO
X-Google-Smtp-Source: AGHT+IHRqr31KNCSXP7Z/0yBPbquY2OT5HTWJj9w7WcR5N7xmXNiwClCJptbegHrPC6bWbI9yVA9OA==
X-Received: by 2002:a17:90b:4a02:b0:313:f6fa:5bca with SMTP id 98e67ed59e1d1-321162a25dbmr11632697a91.22.1754318316926;
        Mon, 04 Aug 2025 07:38:36 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee4f42sm14773433a91.23.2025.08.04.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:38:36 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2] mm/damon: update expired description of damos_action
Date: Mon,  4 Aug 2025 23:38:16 +0900
Message-ID: <20250804143816.29654-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowadays, damos operation actions support more various operation set.
But comments(also, generated documentation) doesn't updated.
So, fix the comments with current support status.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]:
1. change baseline from damon/next to mm/mm-new
2. Add note about DAMOS_PAGEOUT and demotion.

[1] https://lore.kernel.org/all/20250731132230.80046-1-ekffu200098@gmail.com/

---
I also watch your comment from [1]. Thank you for not forgetting :)

[1] https://lore.kernel.org/damon/20250801233942.1614-1-sj@kernel.org/

---
 include/linux/damon.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f13664c62ddd..d4b3ffd6144d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -110,7 +110,7 @@ struct damon_target {
  *
  * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
  * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
- * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
+ * @DAMOS_PAGEOUT:	Reclaim the region.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
@@ -123,8 +123,10 @@ struct damon_target {
  * The support of each action is up to running &struct damon_operations.
  * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
  * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
- * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
- * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
+ * supports all actions except &enum DAMOS_WILLNEED, &enum DAMOS_COLD,
+ * &enum DAMOS_HUGEPAGE, &enum DAMOS_NOHUGEPAGE.
+ *
+ * Note that DAMOS_PAGEOUT doesn't trigger demotions.
  */
 enum damos_action {
 	DAMOS_WILLNEED,
-- 
2.43.0

