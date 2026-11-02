Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632089;
	b=d0FSwJkrgGe8hxKDAcSItB2eHmtDrMkM+ibSf8lTVRJzOJRQMaMARj5KGv4XYTMeCYkh
	 ZWsSdZbAOH75f6yyZMrIbdOgaq6ZYYRilIyU/Bx9TzNCAfAWDol9O0an0irJ91W54XbM2
	 /u+0nC8TNCQuyWLlr84bn3tb8JFpg63uFDNuUstEt96UoTor4PqV5eWmcQRHlkEjTge2W
	 FCr3Lyr8R7M3iK9PBkXvtyC/oUlVZTJj4fSPB2WnhAzUSEmbw4tJWQkXHHQ/6Pra7OIz/
	 xaxmnlr/2DoKLs1Usqt+mMLdaoFasRXPRM1N6e4cNepk9mFEjXzwp2NN0Tvc5hIGnBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EOIOo2WRViZfcB5LyNG3dNe7ZyXvt9pNDQFYal3R+A8=;
	b=lZCcaJ078KSGqEp4ETxgsMgWPctV0Mo2BI9kPvMoqF83ZsK85CPNV4049/9Bf8Ntd7+u
	 69iEPz6tNuVcMlNjXqXKAbDU2qwhrrgQJdfKpt9UyzuvU3dPk6E8m5o0PmuTC9TL4n8H0
	 mH3dnw0vdjUBo08dPDUR6sZ6FHL2XdgfN2AUGF9gK8nOWXzWpESd6y5QpXibKlTPWeMT1
	 RkXWubky2IzYjyXafiD71DkMO+vsRaWINXu1Y0ctPMYwNpkk4xRJabyXSpl3dUpKJbR7d
	 PGXKaAMSNLanhZVvGkhxxh2bAriZkOaRqMJDFyKxosM4uJD6+9dXHXzWG6tHKvduq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ3jzzXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BE60A1DB5;
	Mon,  2 Nov 2026 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ3jzzXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10721F00A20;
	Mon,  2 Nov 2026 15:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632089;
	bh=EOIOo2WRViZfcB5LyNG3dNe7ZyXvt9pNDQFYal3R+A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZ3jzzXe4gx8n7MBZeCRakfm9HOlLvf9jFjlwFESg5Jm4sD/MhZAQt8kb5DlUnOK5
	 DNbU47GQk7H9ZMFiNYeXo9J/oYvXNRctFi6Rpt8O14AS5hvsgGF+mRRfcWT1TumK9q
	 cHUdHZfgyt1jRhTXCc6xTE0ZebWXnQsYzVTUfNWdcbuPKU3CoDrowWsFP4yG5Jj2iZ
	 Vy6SgRoqAo1Hhj+CQXjfKfluEIBUOedbelAexoQjrqaDyCs8eBBdMDrsSN/49zhbd9
	 wTo/4o+CT6VNTeqiaDES5LNSgGaJQKD2BmpAt6ItswXDb1fp5oHS1Ui3exVch7ZPlX
	 OqkAAEfW8FnSw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 9/9] Docs/admin-guide/mm/damon/reclaim: document how to disable watermarks
Date: Mon,  2 Nov 2026 07:07:56 -0800
Message-ID: <20261102150757.93058-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

DAMON_RECLAIM runs its scheme only while the free memory rate is
between `wmarks_low` and `wmarks_mid`.

But some users want to reclaim cold pages even while the system has
plenty of free memory, and it is not obvious that the existing
watermarks parameters can already do that. So Document the setup.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261028023628.795637-1-ruanjinjie@huawei.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 Documentation/admin-guide/mm/damon/reclaim.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index ec7e3e32b4ac6..14f9b82b38ed9 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -193,6 +193,10 @@ DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks the
 watermarks.  In the case, the system falls back to the LRU-list based page
 granularity reclamation logic.
 
+To keep DAMON_RECLAIM always active regardless of the free memory rate, set
+``wmarks_high``, ``wmarks_mid`` and ``wmarks_low`` to ``1000``, ``1000`` and
+``0``, respectively.
+
 sample_interval
 ---------------
 
-- 
2.47.3
