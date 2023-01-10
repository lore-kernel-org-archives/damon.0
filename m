Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4FA94C
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235EAC433D2;
	Tue, 10 Jan 2023 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377448;
	bh=yhlx99wApZuf1+oxV+tS5tr85ZKJgTLb2t8Dhjj3q6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fw8T8JX5qowhaM7imY0QxW2TLNYGjTeDjVNkpnJQmEbxf5CNLt8o+rYHK3k4Db4Ct
	 JdhmGxrvKh46Iz1btrYZ2FRwg6N3qPm9NMLs8Ocpt7517+bN7F4lVHnKks+XUAqqsk
	 f/2Tas3X/hU7xq+zQwB5Hj76Z6YB4voWxzE+Ql6Hbcytnpo4Qt6IWBimgn+D0cxp/4
	 ijA/gPb95yECvGpimIHZChLCYtAfHO59f1Hyh+cvixYJyYwUWlM/W4e2JX54hUXYL6
	 cWm5irf5P0+fa+F7BOltbdvyueoCHNnKyEtHSkMGWBFwM+4mMSf/F/L9Ln4J/tzmoP
	 EYy2wqxHACKIA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] MAINTAINERS/DAMON: link maintainer profile, git trees, and website
Date: Tue, 10 Jan 2023 19:03:58 +0000
Message-Id: <20230110190400.119388-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add links to below DAMON development related resource to DAMON section
in MAINTAINERS file.

- The basic policies and expectations of DAMON development,
- DAMON development trees, and
- DAMON introduction website.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a0c3d3b9093..4b222f67663a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5790,6 +5790,11 @@ M:	SeongJae Park <sj@kernel.org>
 L:	damon@lists.linux.dev
 L:	linux-mm@kvack.org
 S:	Maintained
+W:	https://damonitor.github.io
+P:	Documentation/mm/damon/maintainer-profile.rst
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
 F:	Documentation/ABI/testing/sysfs-kernel-mm-damon
 F:	Documentation/admin-guide/mm/damon/
 F:	Documentation/mm/damon/
-- 
2.25.1

