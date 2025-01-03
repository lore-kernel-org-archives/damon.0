Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623641FDE1A;
	Fri,  3 Jan 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926260; cv=none; b=RpkJ3KO1yVgivjiKmpmw55wPO89iX+l+PC0JgVKjjCEuBBuDjD9H4M8wxG0+pWwRqwvTtExxlVuTRgs6ihLTeSzynzJTg0q0NahEA0bjowM4IIHFKsXR/Hb2dpQrq9e2fDube/p8qu6HAmkNipGrUJ+eMsZZzxwQlSyVtkzZMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926260; c=relaxed/simple;
	bh=ex2cW5mU/E6fAA+W/k+OvrLTIak6tQKdwMDzL9/VmTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGLCjKCTsf7rf/0cEw5Ymc0ry36kwMinVBHMImfTrm4FNNBJRsdY5ZkSmBKTVdEAegFxPmRbowESigi4JlJ2pU9jt3gKLXJjBXyvTy2beNrY86WKhvy11PSxHoOCXWWep6VhRJ+/8hPy34/FKNUl47BUxL4+ukChY1eDu1FzE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7dfKc9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7dfKc9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C88BC4CED6;
	Fri,  3 Jan 2025 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926259;
	bh=ex2cW5mU/E6fAA+W/k+OvrLTIak6tQKdwMDzL9/VmTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7dfKc9LBbs8Wmv5ZSOAcOMAI9VAqDjbrtYkn5A85z4azDq2JNjiVPD//CxORn3ta
	 6Uop6Gjhi0KTg5+K1kU7cYPVCLaXdZdrbhJ2eKeu1VlcrGYq4LNDYbb4hDy6Fyqe37
	 kjIgj5NXNwzh0TcMweafCE3/jKAghPfv6woal8w7hiCLf/Dw6tCFB6SvWBib5Z8CwX
	 eS1/mmfeJmf70lJ0mre8qE1gmOjkmbXyB3JKwgAc6O6CrJ0q56KFDGKLDYB8wVU//e
	 LMac1HM3Ib+1+pVXBW8wkokXKU9UxUYkVoIr1+GTHGjt/Sz12bGhaw9k2MRimS1H2Q
	 DIbdDtIJYiCfw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/10] Docs/mm/damon/design: document DAMOS regions walking
Date: Fri,  3 Jan 2025 09:43:58 -0800
Message-Id: <20250103174400.54890-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103174400.54890-1-sj@kernel.org>
References: <20250103174400.54890-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS' regions walking is a feature for efficiently retrieving
monitoring results or DAMOS-internal behavior.  It can be useful for
multiple purposes including investigations and tuning.  Add a section
for it on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 1c8a43b07b00..5385ea04c2fd 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -540,6 +540,17 @@ To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
 documentation.
 
 
+Regions Walking
+~~~~~~~~~~~~~~~
+
+DAMOS feature allowing users access each region that a DAMOS action has just
+applied.  Using this feature, DAMON :ref:`API <damon_design_api>` allows users
+access full properties of the regions including the access monitoring results.
+:ref:`DAMON sysfs interface <sysfs_interface>` also allows users read the data
+via special :ref:`files <sysfs_schemes_tried_regions>`.
+
+.. _damon_design_api:
+
 Application Programming Interface
 ---------------------------------
 
-- 
2.39.5
