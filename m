Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597B332ECB;
	Mon, 27 Apr 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302761; cv=none; b=o0XGodtl6+FfG+nAa5hEIOkD9wFhyXpf8WWI5ol7rHOxxXgZrWQL3YRbXXl8xz+FUbjMh1FkC0JJshnD0Ljyi8Xp+LmK1+iLTczBZH9Was1EUOKerq2GkyhMK681yVkXOEnO9wAGA3otM2ABZVx9mqquKOojwYbWnksBRRvmYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302761; c=relaxed/simple;
	bh=cefZkLteoGUCWc4MRoifuuAEqrfO3tIQ452Q0kCEVdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eitN1inJWHwH35SYdOGLbLYDhq+gQQcRCcOGgXC9urkZveM/anQfXImuDky28Leo/WYBk9uYIkuTSf4xODTWgkz87yFoKk9TIQT7k40yyjvBnW2P/KNAT/BpaDmUAoGPnfBDn+Hl3FaSjqNmy1jNLwF6sf2FA6FNRp0+eAFAZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njaiG58w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njaiG58w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C19C19425;
	Mon, 27 Apr 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302761;
	bh=cefZkLteoGUCWc4MRoifuuAEqrfO3tIQ452Q0kCEVdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njaiG58wjsoDLEqvI2yOa/BxJ00RrwagWompIzbxHgrQ58S+/Bsnq2TIQK+l7yvjm
	 1iuSJc3qvdzX/n1j+GgrTOsHCUrlV8VhnNjgsojSBdOkg8jjbK2bSGYCtHgXOzSrI6
	 A0umOBQDdD/THIPDnwDAd5v4yh7TaR5S4AkibyBJ/kKWY71cFeD7DTfgnUNI4QxkRu
	 RY4JyOYgROABt/a8OU3yOKMocI/3TZHv8ZAsfyYys1SW1lrA3e9cXM1ezBnVvfmGsx
	 4Vr5PRf4PYjssXCFEkjOcgKTzKONXW8wgVv811rASHZlOjrTIWBuuVOUgpL+Sbq2c7
	 ZVKXX7m3WX56w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH v2 03/10] Docs/mm/damon/design: update for context pause/resume feature
Date: Mon, 27 Apr 2026 08:12:22 -0700
Message-ID: <20260427151231.113429-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427151231.113429-1-sj@kernel.org>
References: <20260427151231.113429-1-sj@kernel.org>
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
index 365e068a8dbe4..622d24e35961e 100644
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
