Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC3125A1;
	Thu, 30 Nov 2023 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab3KL1CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95400C433CB;
	Thu, 30 Nov 2023 02:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701311824;
	bh=aVQYYR7Wa2j5FcEbEqZY4GpoX0ij3ZW/t2YkLOpkPDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ab3KL1CA/Q1LdHqbROyoGrBYbAzm+vS90RXg2E8BXqXKEg5WEjZojHnxDn9nYqvD3
	 F1f4Im4M6vU9+o7l3V1SvkvjkldXXrKbk03T1no8M0JuRDCfSx/Iy8YOPKdDINT6FS
	 ISWn3NNg2kx3/5L0ud8yO5DiDbbsFVb4sZYKvK+PPVjRqXcqDYrl9PDurGehZAeban
	 sPc/85by17P4PosFwLVgg3428nwiR3rQRMv29Ggy/BIrzH3ZwJinZk99qOHsE3XUAg
	 eXbFr3YYNbMNjrS+iX50I9+vg6aZId9yd3e0qppFUtYx8tISAFwq9gnrCu7zl70r82
	 fbwlXVVYwoYjg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] Docs/mm/damon/design: document DAMOS quota auto tuning
Date: Thu, 30 Nov 2023 02:36:50 +0000
Message-Id: <20231130023652.50284-8-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the DAMOS quota auto tuning feature on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 1f7e0586b5fa..947c9df6cd33 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -346,6 +346,17 @@ the weight will be respected are up to the underlying prioritization mechanism
 implementation.
 
 
+Aim-oriented Feedback-driven Auto-tuning
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Automatic feedback-driven quota tuning.  Instead of setting the absolute quota
+value, users can repeatedly provide numbers representing how much of their goal
+for the scheme is achieved as feedback.  DAMOS then automatically tunes the
+aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
+is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
+is over achieving the goal, it decreases the quota.
+
+
 .. _damon_design_damos_watermarks:
 
 Watermarks
-- 
2.34.1

