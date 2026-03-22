Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D33644DB;
	Sun, 22 Mar 2026 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195058; cv=none; b=FoM/F13NTcpkLZO1M5gxN7nrm2/9KJPohZRLIex0VkIK8YFwx/UBLz/z9xNlbxRyfCoAKcNA20Kw02mRCd9G8MsAfbMdtFMEspvRrFhmXc/lu+oW8qVYYdpibPygxs6OmCrXgou7ny2bjrkJjkFfFTWh7bvszESXXmpADDQmdng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195058; c=relaxed/simple;
	bh=qt20gza/ZGfZPnGlsbY2CkGg3eBlVlFouLw/z7b3qI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeVz1AfOSvNCTblK/uHXKcFwC7SydKSh9IJU+nU3oez9KV6x8xe+MHdMwprO5rubW45Ab82EZ31yO9CRdwjbZX5igpSGF1Fwj8mc3Ayk7PuftRsMU+peKctajYUtr+tyyf+MCDCNskoPcfNQ/eBNWO0ndNSOOKoDuycN3ll9nR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx5CvT34; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx5CvT34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB1DC2BCB2;
	Sun, 22 Mar 2026 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774195058;
	bh=qt20gza/ZGfZPnGlsbY2CkGg3eBlVlFouLw/z7b3qI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rx5CvT34RmOppQtu6QxfqLWQzRWwbcWgOty3/B822ykfngK25Ar5ud10emwDWJIzS
	 xrEbTwTN4Mx+Ijeq6WJ6Cfopp16atDTZN0nQ/OHcImSj1OlTi2Zs31rLD9SSMvBOUP
	 erd9CvY3+Rt/aaYAN9stVROOuOWyOuRAVQRbrDGv/ac7nryJP42qaCjaRszDv9iYF7
	 a+VXzrHsDhX3ny7VVnAM5c/lM4uZqcHI8g5ll/L2LUGj4cD5ei4CiRjVPasL4mABVv
	 7o8+fEfU1WfOa0hEGojJo8HqcsfbDBMjUKChQJfl/1aCCoUVAD3/Ji8qlovGLWLuH2
	 DhGyAe/DjdiQw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 03/10] Docs/mm/damon/design: update for context pause/resume feature
Date: Sun, 22 Mar 2026 08:57:17 -0700
Message-ID: <20260322155728.81434-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-1-sj@kernel.org>
References: <20260322155728.81434-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index afc7d52bda2f7..510ec6375178d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -19,6 +19,13 @@ types of monitoring.
 To know how user-space can do the configurations and start/stop DAMON, refer to
 :ref:`DAMON sysfs interface <sysfs_interface>` documentation.
 
+Users can also request each context execution to be paused and resumed.  When
+it is paused, the kdamond does nothing other than applying online parameter
+update.
+
+To know how user-space can pause/resume each context, refer to :ref:`DAMON
+sysfs context <sysfs_context>` usage documentation.
+
 
 Overall Architecture
 ====================
-- 
2.47.3
