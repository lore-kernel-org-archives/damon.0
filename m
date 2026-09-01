Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E63A483811;
	Tue,  1 Sep 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269122; cv=none; b=uX517c9uwpfx2s1ZCiwkl4akgLhFUR+fyk49PtOTdTbJMAqsA/GZdL6yyZi55rwhkkbk501ggAnO/KliJHpA2LJXFzjGLvyjfQd5bW/47ST9HZdaCNTiP6l3pQRooympd1TEY6mq1w6QY4Ux/8t7c7taHk51Re2IliRC6OYeFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269122; c=relaxed/simple;
	bh=AsHoCbwMwQPn54Uh42zQM6XfaiQXavuQ492jVm131qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyJ4+21UO/6iDnpbvnoCAGwB2cIQiN9Sbgr1n37BvpMfnf86WSB6Wn4HOcLunWxbs8HmRWyqF5FhOkGoBEx5yUqEKHXZY2RwQNAz/yU3uTHph429PgAWtqG/vqsewrF354gBuEnoeURzh+iM7sOk9vISomSKUnJ56M4NmbgwZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMSipk8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMSipk8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF59F1F01559;
	Tue,  1 Sep 2026 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269120;
	bh=CpXkgOmW3GSwhrOkMdO/S1mj76NXWWV8m3WM4J70bcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GMSipk8UkfFIcDDvF7JZOpQ51OlDWE7AOEaYd09MsYdaYHkkpPXXCCoqVV7aN89la
	 57z2pqMr+WWOj6RieHPXnhPpP6e04h3p0BuAdUHBkTQt7rnyI3B3uLs0qzYe9Sgzxx
	 zOelOFLUtOdrdche2+1I3cLfGOzGwOO6diu735898YqgOqb5jUBldpRlsZw/wu4r7y
	 72e7X1zV/j5GM2ETzVC7IdrY4AuRDHaqJ0BsOldg5PiGnB3afG7XvPwGGSDmdVNSHJ
	 f5i/sRhT0sNVX3RnwKRTeDiwMoFPe+WIrbN8VWpLYy/VLrrtAqcyPpvVcMxhsx/nF/
	 CcC7v1hGjZCfQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 15/17] Docs/mm/damon/design: document probe preps
Date: Tue,  1 Sep 2026 06:25:02 -0700
Message-ID: <20260901132506.99243-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added DAMON probe preps
feature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 947d91ae24a39..d036340dae8af 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -309,6 +309,13 @@ Users can therefore know how much of a given DAMON region has a specific data
 attribute by reading the per-region per-probe probe hits counter after each
 aggregation interval.
 
+Users can optionally register probing preparation actions per probe.  If such
+actions are registered, DAMON applies the actions to each region's sampling
+memory before starting the next sampling interval.  Currently only one action,
+``set_pgidle`` is supported.  The action marks the page for the probing target
+memory as access-idle.  This can be useful to be used together with
+``pgidle_unset`` probe filter.
+
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
 understanding of statistics.
-- 
2.47.3
