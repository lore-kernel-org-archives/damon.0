Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881C1CEE90;
	Tue, 18 Feb 2025 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918235; cv=none; b=BEMNHr25NCIlymhx/t5dbojqf56ptJew61xmdAkIH8uDsao6Lico7eatnKlv1Ty8HaQ3L5MXKNSSD3qnqillAOfNM1Zpz/dvlXaJkFOmKpVlivZJo/eH3HPDdWPP4vd+Pfdb7fcgESlehYji0XooXasnawRoKdPhuvJ15RZEM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918235; c=relaxed/simple;
	bh=rd8bvWwFr3TQe1hBMlmDyKFsebEGzquS3uDcV7Jz+1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nx057QX1BiWJ8noosHEVreOiL0q1nVy9FtLUo7RvGweImFm19+Ls+8unFqSTmtqwto4H9n53ooUxBBWhHPe7m5wwD1fodKYpqn+5/gy6ZvofC/5OpXqeqygVrVbt00vGBWKHm1DSKAW9swm+n8VVPLdJz5QvJs4YpOzhpD1VpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOgupre3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOgupre3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641DEC4CEE2;
	Tue, 18 Feb 2025 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918234;
	bh=rd8bvWwFr3TQe1hBMlmDyKFsebEGzquS3uDcV7Jz+1Q=;
	h=From:To:Cc:Subject:Date:From;
	b=vOgupre3yG3OawnPoaHjMImeDXdjBwMCpgvGK6l4uzoqQCAb4OPBKCbR2yVKhYtSI
	 FkgK9OpjNP3IxlOhQ9e0vbyX0RlM7HmKktK2gZUXPX91cn/PruLxk3MY8PjvLGELZz
	 G4Vm48G3l+GBa6qLadN5jjrI5IgHlOFg1Xgu6nB8NEOk5sQmSGu0zC9dy8n4ldZqQT
	 V977vxmOTBs3ii6VDAROrit6vppu4BULweZ52Db5b+6RcgZTU8J0DzKzjqwraIcmTz
	 M9H1GwBXIa7PVg4VjYS3CuI57OZ/zBqKsDXXDYutwsLIY7bNJ8atpL+uJudhB0EZsx
	 cWNJtYGoAK78w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] Docs/mm/damon: misc DAMOS filters documentation fixes and improves
Date: Tue, 18 Feb 2025 14:37:03 -0800
Message-Id: <20250218223708.53437-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix and improve DAMOS filters documentation by fixing a copy-paste typo,
adding hugepage_size filter documentation on design doc, moving logic
details from usage to design, clarify DAMOS filters handling sequence
based on handling layer, and re-organizing the filters type list for
easier understanding of the handling sequence.

SeongJae Park (5):
  Docs/mm/damon/design: fix typo on DAMOS filters usage doc link
  Docs/mm/damon/design: document hugepage_size filter
  Docs/damon: move DAMOS filter type names and meaning to design doc
  Docs/mm/damon/design: clarify handling layer based filters evaluation
    sequence
  Docs/mm/damon/design: categorize DAMOS filter types based on handling
    layer

 Documentation/admin-guide/mm/damon/usage.rst | 28 ++++-----
 Documentation/mm/damon/design.rst            | 63 ++++++++++----------
 2 files changed, 45 insertions(+), 46 deletions(-)


base-commit: 754c08bc32083abf5b6b43362b8d6977d99cd9df
-- 
2.39.5
