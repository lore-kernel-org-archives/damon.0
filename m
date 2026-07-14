Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04B47CC9C;
	Tue, 14 Jul 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037690; cv=none; b=akJ3obOCTS/wUbxys80ovmoBbqPSZOjYFkoiQzQAa3uKbYuiI2KDir95+U5nayQIyPHNIAMu7k1T71BPKhMD3kyDPt0Igb5zRd5j3hE/akjO8N10V/+cU2CrmDmKDJTWwHkV4sicVdY2leLODZ6XerQr9kP7GirmUXgLEbd7JMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037690; c=relaxed/simple;
	bh=F2ctYjbOXJA6k3tpwq1NORArTe96BERc4xXnwMefw/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usf0piioljAP0KOJCS5wNOrYDkk/k2RYIXj0McfeeYhRpwN7ae+O1yl3S//z+Bnd1pICoNJVjmIYSv9wzHPW1y/bZqpx2rL/efbHI2P6w+x6w46BDeTgpVlytBggmpdOr8PmeETrtsRrAH301JIwmMgYAhuefstYa+Lwo8rN2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opJbIRfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opJbIRfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DC41F000E9;
	Tue, 14 Jul 2026 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037689;
	bh=1xev+RArxStO4Y/fnuMkgg5H8N0EqMUfi6KCHf6ihSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opJbIRfxqGTV9/18goXySzxETF/pZnh0raFiuig78hrgEJkiIUC6Qx2izzC1MXb5d
	 VE5R6g9rINCV8X/9J1q1/kXRxyzE2ULnNeJpw8a6/lqtqRKzLBeXSaqy7dRbb1k3bU
	 rdY57GxrUYI7yRG8IYR8tMj7xmdTrC/V1jyjQB1BahjxvMHxWDZJpVpIG5clHr2/ii
	 yw/bqRNlvRKcz6vvyPuryJpzCuWF+A2aiBK2I2vpqF0+gnsi8Nx/lUOGIUOuPmYTUi
	 TbEFbLoPE/LP9UepXvgB181bZsyKxePo9AcHmuzK5uGqogU0Fk0LXeX9MhoWm3AcRG
	 eZ5n9ZxU9xVaQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Song Hu <husong@kylinos.cn>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SJ Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 4/4] Docs/ABI/damon: document tried_regions probe hits
Date: Tue, 14 Jul 2026 07:01:16 -0700
Message-ID: <20260714140117.94147-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714140117.94147-1-sj@kernel.org>
References: <20260714140117.94147-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

The 'tried_regions/<R>/probes/<P>/hits' file, added in commit
5b0de1bc3325 ("mm/damon/sysfs-schemes: implement probe/hits file"),
is described in usage.rst but missing from the canonical ABI document.

Document the 'probes/' directory and the 'probes/<P>/hits' file.

Signed-off-by: Song Hu <husong@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 1507e63ab1711..e675a57145e36 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -650,3 +650,15 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Reading this file returns the size of the memory in the region
 		that passed DAMON operations layer-handled filters of the
 		scheme in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/probes/
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Directory for DAMON data-attribute monitoring probes of the
+		region.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/probes/<P>/hits
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Reading this file returns the number of data-attribute
+		monitoring probe-hit positive samples of the region.
-- 
2.47.3
