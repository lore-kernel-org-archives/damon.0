Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93243137750
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022842; cv=none; b=XEiRjPaKcReek9KHEjihFD47EHcn98tZyvExbJr0OGlJCSMEcXFI7hukDowq8wHEy2nc+YJRuMVdRXyDiQ4EjUSex78h/qhnqI7K/PYf3MKTb8qitXDtaBaQFpRmhGLjFwQzXjYekc6gqDpjtwzm86fAjEB3D0YCRfGQKLeFeOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022842; c=relaxed/simple;
	bh=2noVsCQNVQLRiGq6reRkE5gM+8BX0pVDlcLEQw236uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9oWatC9d4lQjTtvAmDjs9vw9b8kDRUuIxHA7pKmHcNLxAdcVvaK69MzwM25ahBfDklg45WDMZUiTPd85Ckrj+C7ZlUH1C7+vnOP9R1ZBq1gFB+otshNuMTjOBy+HUSVgBYM/7AK6SJpwTOIcVzlp4oZmtZDcDK380ORtx5Ijt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqut3yGR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqut3yGR"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e812c817de0so3927201276.0
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022839; x=1752627639; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0AEBACIj7iufFFEjwK+DXtNtO5oq6pBK1Svk06pLxI=;
        b=kqut3yGR6YfCWNH7B31BWRz6lLcQyVZHgqXMQqQyOBL8GKY22G90E+2snO0kgZQ/zX
         RKQD+ofem3rb5i0twM1GPZnofKMrdJlREBOeZLWlxJPVvxr+uJkrdt/mD5qikD331HeY
         Op8IXKlKbJdTRSppAASMNRDpLrecF9Q2Affu6ypy1CRMfOeuQ9FFl+7xBo4mzmXJleWm
         MKmBd0TRRx/r/1G9hKbwMazac83nme/ktKm3ijO/ZIOfJQpbTsyPPm9Fkmt+b0AZwG67
         vXqSW3rNx4rhWU5FALFBqia3SEnU/qkrnMDBDYwYJfHYZPNPS0fZZWIccps95m6QpSfz
         mMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022839; x=1752627639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0AEBACIj7iufFFEjwK+DXtNtO5oq6pBK1Svk06pLxI=;
        b=PF+CI/9V4Q5h9k1DmQTMrjZO6SfX9P3D07RXbym8blN0RdM2Dvx5nKzKRQlmuDlv1D
         sXvQBPPrTyb6yB9rcaKy1VFA0LTgbhxjUHJnrM/cwbzsx7exrdTAELe1zhN525BcNjQ0
         Fbrb8huvqKl8zQWawV4TvNJKzFHGjASFNp1jNYybmdrQ4fYsbQDiSOvQ0ZI5bu9SWfaS
         e07DATVVaRW7ySMJQicJ6GGzSrDqQtk9BF5gtS/hBIeBRkKmN3eHwSaXP7PaSdH/Aria
         Ptt/2/tjdvgh9Om9kYx6Pgo/sAM9fGcg6G6Tjx0SYxHShhaeFjyWZ9CW2pOXMUXEqc6C
         Rgug==
X-Gm-Message-State: AOJu0YzEDR5+kBbXyAxK1+89qaRMKojaM4oTerN2wV1piemtCYEEB4Kj
	6tkfwvr5fBoVoW4z1O8fyBPsjSXpXfATKOmC5C/wMGRpi+sTpdU/SoMMyBpYXpDFQ6c=
X-Gm-Gg: ASbGncubQkgjk2ysn8q/GNMBBcn9pDOEUq+pZXu7A36NJVfRAuH9jsc3waxNoopU0vq
	hLykkDfBXw4KVB2GlWpMeZOkws81yIK3D6XlgbpKAAZY0xAJBayDQzl44oeag2MKh/enk3M0HYa
	9qA6NYs0ThyIEeSLefV4Toxa7dui+BpNi+jXfYQsT6Zd1DUaqjAR2DMaqQ0oitfHrmNwC5Vm7ns
	Zx4KoqOwGtSz5fMan7WNvS6gSXOCNl8JT19v9uReGOLC0cBIIbEsb+dFKTOWxwvY0n5wgoAebXP
	+ZQNwbVFEHuWYCLFOWchdrOOZPJQDlPvoa2pyqGWq6GONrY3D7ceiPaXIDDG5YsoifJS5sWRv3N
	k3RlOp8w=
X-Google-Smtp-Source: AGHT+IGDozJUCJpVBxPfjv9ILiQSL1R6miXqzbkK4caVqVpgbl+9ZhuvLHM+DyHUEdodqwUQX37wGw==
X-Received: by 2002:a05:6902:986:b0:e81:9b39:e46 with SMTP id 3f1490d57ef6-e8b6e102b32mr1051961276.18.1752022835632;
        Tue, 08 Jul 2025 18:00:35 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:35 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 05/13] Docs/ABI/damon: document schemes dests directory
Date: Tue,  8 Jul 2025 19:59:35 -0500
Message-ID: <20250709005952.17776-6-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Document the new DAMOS action destinations sysfs directories on ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 5697ab154c1f..e98974dfac7a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -431,6 +431,28 @@ Description:	Directory for DAMON operations set layer-handled DAMOS filters.
 		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
 		directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/nr_dests
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for setting action destinations of the scheme named
+		'0' to 'N-1' under the dests/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/id
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the id of
+		the DAMOS action destination.  For DAMOS_MIGRATE_{HOT,COLD}
+		actions, the destination node's node id can be written and
+		read.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/weight
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the weight
+		of the DAMOS action destination to select as the destination of
+		each action among the destinations.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.43.0

