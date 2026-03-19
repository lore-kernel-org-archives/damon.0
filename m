Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC939934D;
	Thu, 19 Mar 2026 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897728; cv=none; b=JAMKP+BhHTy1MoGby71BqBillWuVoWGP7s8ncdricRMTpVoWzEo78SK2vfl6uHyIsONTQDmIdZV4SCh7peOSXkB3bqxOsi1rKh35iCLlneIAud1fCzFcL4trRDPECDhwr/T6ByQatnF7IfSaKMgebhiMeS6htV7fDo1e3t+PAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897728; c=relaxed/simple;
	bh=Xzm+JNkj3Yeb12esLxd9yBTp5fRgZ5ByNKV19KwHmDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bed22wI2I0q5FQb3y1ZeSzYtm3C0Hy93BmUGH08ZQqZ/iAKoc4OaDTYb4eP2h8XR19CuQs6WJwB5fhFyJE4UNl6uHvHi2VTFpmRbhoYJkWFYzH77FFHuzFUAXGVdtlt1MGv0EsZTS5NrtO0gVBg0pbeQp+/1eB9+iESA7YmAxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3czYL5V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3czYL5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83E3C2BC9E;
	Thu, 19 Mar 2026 05:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897728;
	bh=Xzm+JNkj3Yeb12esLxd9yBTp5fRgZ5ByNKV19KwHmDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3czYL5VHrXtOTWvqFJCV/UmAYYYkP5VakJDq+d/YxslDrCYDJlErt4+uYhXOc1Hl
	 TeWisEWjP1O4bcNYk127D7J9mPz+gtVQFJIpUlNp5vcKGWBLdp91ACjVT4SSAoJ+Tl
	 bYSyUyoFVN2m5GqYnhIi+oGlVnWZqcrw7EWhgG6DfA9q6fUJxUtQv6DYA8/cxjWUcE
	 5w1tl8xpr5WAfr7iDajp1UAiQkSHM48IgvbjropwwwfHE3LwvutLp2ESYbDB0G1QCY
	 Ucwc+MJL8Ueesq6q2COj2EJJ++KpObfLLKSVgumgde7H0gS4gfLjg9hAi8vSxhujhA
	 lWEmpYhpinKOw==
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
Subject: [RFC PATCH v2 03/10] Docs/mm/damon/design: update for context pause/resume feature
Date: Wed, 18 Mar 2026 22:21:46 -0700
Message-ID: <20260319052157.99433-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
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
index 838b14d225193..e2e4fe3fb3986 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -19,6 +19,13 @@ types of monitoring.
 To know how user-space can do the configurations and start/stop DAMON, refer to
 :ref:`DAMON sysfs interface <sysfs_interface>` documentation.
 
+Users can also request each context execution to be paused and resumed.  When
+it is paused, the kdamond does nothing but only online parameters updates
+including resume request handling.
+
+To know how user-space can pause/resume each context, refer to :ref:`DAMON
+sysfs context <sysfs_context>` usage documentation.
+
 
 Overall Architecture
 ====================
-- 
2.47.3
