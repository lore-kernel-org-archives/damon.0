Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CF346E46;
	Sat, 21 Mar 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116833; cv=none; b=ccCbkejt+ZEe5EzXv+pNb8jpc2aIRLiTrcOmUL6vWaGSF1nlyEwqifpatxHbjbCDmsNPD8WoccnNNLK3NB9cgLKQ/fOj2HEoXmLlHXbmG3rnQTYM/RlOOYPGUv9C/jsFgxSMQcpWptaY4hxraUuzISpO9ea+daUL0l0BWZaGymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116833; c=relaxed/simple;
	bh=qt20gza/ZGfZPnGlsbY2CkGg3eBlVlFouLw/z7b3qI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2zD+SQuR/FXOqkSpj8R3cwaLvKzSyxDSwKKbULTsxRqxJlIGXuGvi2aYwkjUzaoaGQXAZ5BaYDP3A1NsJpqy6yYIfXSn2AiH10coZlPjgBTru+vffcX3H1OAQNay1twY9uenQZEHoitvch/UrSarC7K5XWMJsccrTiyxaVTFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLNV3slL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLNV3slL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEB1C2BCAF;
	Sat, 21 Mar 2026 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116833;
	bh=qt20gza/ZGfZPnGlsbY2CkGg3eBlVlFouLw/z7b3qI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLNV3slLgvet31x6TAf1yaL6xK7vDqZMrt7HDDWXeHWUvLdUEwA2lM2Vx1xM23V5K
	 x/SovoUrbEEIzKL0gMYMb6k8zSXpnCmVqbuzFf+E7FQ0+uW2Z8ekdYF8XHjSIYhu3y
	 rOqQ3NjyyIKfoGeizMNE8aZ8S8Vmk9sN/Y5+7T6k8BuDmls5fc3JAHNzTFm1S/Raap
	 fOUSk3DeHGX0n0JH/1Vfu9RG/gIxXrL05fpDPs6SQCftB8qqk7NkmCIE5nIq+V7A7D
	 uOnOWaNVGl18Z2Ro47DiTelLmvCwxb+YAwu12z6x6vDeSfjpJlbN5BAp500KuOKSKe
	 Ce1bqpc5b/eaw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH 03/10] Docs/mm/damon/design: update for context pause/resume feature
Date: Sat, 21 Mar 2026 11:13:33 -0700
Message-ID: <20260321181343.93971-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
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
