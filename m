Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4512495ACE;
	Mon, 28 Sep 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588054; cv=none; b=iBSYKhgyxy2flsdl//7uy8kIQGU6rZ8qPwltVDD93/aB8q4cdyQoQ0cGTVDJbWGfR85srzJEOt2FPgjezr4qU2s8ipLSS0cksS+Z2WVQMwR6JxVOB61gCRUmlwZZKe4iUfFs7evpG8Rwnz5zTWgA0vxxcxc7px+qiDSqNx9bW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588054; c=relaxed/simple;
	bh=o3QDdkDlP/1QqDJR/fSZcv74VaLo/7o5nrPfRMjgD/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuFCmhTuCVA50VFIs1WEqBIIFxxgA/qKirELlaDTyOfnd6LfsCud6hcUfsOGi2jQa5NR/MAxJsaYpW20YXxBgUw2exWsF0LqjEh9m/4hnycwNWEoN+RC3ZGjYpLUmgimIohL7MWdHBNE2SD9jrq+sijznJIfx8aRjwcsJM4ykdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwHxvgDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwHxvgDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55351F00893;
	Mon, 28 Sep 2026 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588053;
	bh=mS1OGjGueuh9xRDDJo/iscVAdMoJD4YdolHQuoVSGCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YwHxvgDoQ21oiFsFvrD/lZITqVRSYeCdA+z6xl6iE2NwnMX6y32QzRBxi76Ccosdj
	 OH82NC8PqhlbRRi3DaAMY9mqjZOKGa5CpKdK5YOEjZmc9z6GJdT7CfTCZyJONGItEb
	 An2j1Z4tgL898koWQyRNJe9U9M0/ovbqnbVr/l0UXZEgjCQPsaPJngwxGMidwPVIT9
	 3vN+6i+4fFGQFLORkAmq3XsLuLfEr+ARUpQbr4t6RZZ/Dm4fT5gveKHy4woMBQpRm+
	 IknjOdJ1vm3ExqsapPzLnkF+S6FbAB9RxscezYN2G/SPOsgp4I+/QeooFtkW3m2VRX
	 QEdpU6XnLO8EA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 8/8] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Mon, 28 Sep 2026 02:33:40 -0700
Message-ID: <20260928093342.16584-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928093342.16584-1-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added damos quota goal metric
complement sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 55df688ea596..4acb2015c2f4 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -375,6 +375,12 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the quota
 		auto-tuning goal metric.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/complement
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets whether to
+		use the complement value of the quota auto-tuning goal metric.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/target_value
 Date:		Nov 2023
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
