Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1825922DA1B;
	Sat, 12 Jul 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353219; cv=none; b=dih9HDDeNx5QVtMr6iQAZfGDZMLB36obnAt/2iEW0nacQz9Om74E7obwHn2U0889MqGayfLZSkdak4QPlMQfBd+TGstQ05itsgWBUtaV4YriIr8OSPxHi1WFl5wZ9LIXVJd6eeqHxKsiV/gJ1VtuDVpMiWZeoMxsNRw6lS2L86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353219; c=relaxed/simple;
	bh=5dKUsHzkX+n8nsnRzImhzFTCp2iFjuwVjkIGRzZyPD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6b/YS7ffZl2f4YUuLjyFBcrWEWYov6A8r3Qw+KAPBI2f26T0ryqrXQ42ZztsNaB4bnk3kWwR7++Au1xh3FTHbysHR6YHGwm+eJr9XqO/b+w7yDUHKxU+izXTlYo40L/8H09k2d4vJkueNScP+KX8Jl8b7Yq/tvOijLSaRmHJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9oOj5Ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9oOj5Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76435C4CEFA;
	Sat, 12 Jul 2025 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752353218;
	bh=5dKUsHzkX+n8nsnRzImhzFTCp2iFjuwVjkIGRzZyPD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9oOj5Okc89QupNrGdw2tu0XqvMtvpcurvJnxj2Xiv7zMSk+qlXIMYR7OdLUHtM1D
	 TpaQDvI7xY0gDscvYxMaC6z3dVF6bgEHMtEc0pTPuch7YppQXr5XCxz+pExsIklxUB
	 ZnhPHkHol3e/8U1Sd5bFcsRcWC0qFXjP5EOqnTJE8FFM1SakIVF/NJzhYvCAK6wmVp
	 cOgDk1nIU4acKX34zBiN2+1AeMZs0mQIO17G/+hKAeiBRvUzIl/Xd1CyMxpHspIe2s
	 JjpgsPhb3PRRU7begjQjL86TzFulV5OPV3VsuDEX6YwqByYW8+RD3t1etMsugJYkhn
	 bcwd5nE/nKpBA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] Docs/ABI/damon: update for refresh_ms
Date: Sat, 12 Jul 2025 13:46:49 -0700
Message-Id: <20250712204650.155988-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712204650.155988-1-sj@kernel.org>
References: <20250712204650.155988-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DAMON sysfs file, refresh_ms, on the ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e98974dfac7a..6791d879759e 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -44,6 +44,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the pid of the kdamond if it is
 		running.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/refresh_ms
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the time interval for
+		automatic DAMON status file contents update.  Writing '0'
+		disables the update.  Reading this file returns the value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/nr_contexts
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5
