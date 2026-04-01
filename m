Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939ED478E5D;
	Wed,  1 Apr 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060803; cv=none; b=F1ku+ABoEYWd+oTz0GkYm4MjZ/TicMvqr8z88X5ftaQ50Soo1NKemQxGVFUepb9mnVqD92U4FTeffpAmP7mzyujgZKkTE4KIN3VyLOjFYsB7nKQljCnXFVToyJbspGfusCAz0Y8YKXnTgZbHIfG42rAmbXtM9OtM905H+DdNNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060803; c=relaxed/simple;
	bh=UfYUZlFWRjzYif75WPtqwBzu4paaT9yYRTVyHk/Y778=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOPLMlJrrTAGjZm6E6EHNdYb3SlKr6snsFbRSVZpeRgk5J0bEspnp5dkgtL1HlQf3C4a1XL1jvFauZid8hGUBU4lwuPJmNSoBOZsG76I3vr+wEGEntDi1WghoVx04ymgWCv6YAKQBq1g8FMUQHglQn74hILxXVNxIadP5R0xlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbN3B/3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbN3B/3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203FDC4CEF7;
	Wed,  1 Apr 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775060802;
	bh=UfYUZlFWRjzYif75WPtqwBzu4paaT9yYRTVyHk/Y778=;
	h=From:To:Cc:Subject:Date:From;
	b=TbN3B/3yiOahkkPLsC89z1Ytnwx8CxDMY8EfS6lANVhai8YUC0t53qhU8XpDmvkE6
	 I+6JzZ/t69YLeA4q2OidESocZY7EJVpVocCyj7C1+rMuapQJwcQ3h4LnU9KraGO0Pg
	 k3B8jWRJnKY8JnebryiOJLjZGJC3d4KpBLek0IUw8p36rg83IS2d/jRtLLYPkhohfL
	 v00JyYA0rpcjibsQdLJPHOGhDP+zUDRwTSQCHZocjlF/Om/tbx2g5ZHYHcz3wPK2kO
	 dXEDtFUH3OFI0LOPbVToT2f1s19Di45zAefsrpSUFIIN9njGY4Vg5LnvuC0zePp1ey
	 kMrsxDiVzik0w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] MAINTAINERS: add sashiko as the first DAMON reviewer
Date: Wed,  1 Apr 2026 09:26:36 -0700
Message-ID: <20260401162637.68506-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko did arguably good jobs at reviewing DAMON patches, for multiple
cases.  "Today" is the greatest day to give sashiko a credit and the
responsibility.  Add sashiko to MAINTAINERS file as a DAMON reviewer.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16874c32e288..42aeaa858531 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7041,6 +7041,7 @@ F:	drivers/platform/x86/dasharo-acpi.c
 
 DAMON
 M:	SeongJae Park <sj@kernel.org>
+R:	sashiko.dev
 L:	damon@lists.linux.dev
 L:	linux-mm@kvack.org
 S:	Maintained

base-commit: 36cdacaadf95f0245cfcb76c0b0cb7e6706b05ea
-- 
2.47.3
