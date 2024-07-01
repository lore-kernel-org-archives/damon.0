Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0216117166E;
	Mon,  1 Jul 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862036; cv=none; b=Q1JnqhaDN564eQ56sIJ5OKbsl6cbFklhsGqDyrOnvASJ8EHvQK76tAX4zBfFHVdKxdLr8bgWWeuIVPKn2rrhoAaZOHcyKo4qfviIDTJFEzuvtVZjkZoJWFiHuAWKNDvKo1GrhfOKU4L80Wss21/KlGky5lgRVO5xtMFrk01UNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862036; c=relaxed/simple;
	bh=kzj696pWU8DWR5Tm6fgirfTDKawz+VAhGd1JZg05h7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDKSrtXY0S45nvhI5vZ2rVSmKl9IeJXAsjH4sTg1icJ5N4HXYssxoUlvKLnKlhfZbAsbnpJVK6DbOcPcfhsU/ru6Dh6W/c+q4QHA+49Bu4keJLxJcs/8mYgJxJK1Xj89IFHfmoNyq4wA7mzRgekpzDBlQZpiFykyow9zwER4KHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMWN3CjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMWN3CjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5F8C4AF17;
	Mon,  1 Jul 2024 19:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862035;
	bh=kzj696pWU8DWR5Tm6fgirfTDKawz+VAhGd1JZg05h7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMWN3CjSlN++hAYJKb89nWhb7/2OGMc60CPhWXTVBX0IT6VL8SKe6i4JtH+4zaff1
	 md8OacaXkbRGlt3+A+dDiz7I0sMfGhXrzphZS5Od6U2+ifY/O1Ji57YaZiMDjiPK3G
	 3Zym7Ht0zxTrCqi1G+zdbDcheGVMFgaf0YBmo+ZaIFP0yiTIf9UWQHpR0MtquynpL5
	 +g30FP+UcFRlYUBcWk3Ij4f1Hm0CzGHb2P0iEAj9ma+6U6JXSQz/EMWmk5yY4CyGWw
	 cPE8D401tb0IIYIGqXKFlGihjHWd0DdkgZyDAFnFxT/7T8+hmp4KbAhz2f5LfRX5N3
	 qQ6XqfTfRquuw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] Docs/mm/damon/design: Remove 'Programmable Modules' section in favor of 'Modules' section
Date: Mon,  1 Jul 2024 12:27:03 -0700
Message-Id: <20240701192706.51415-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Programmable Modules' section provides high level descriptions of the
DAMON API-based kernel modules layer.  But 'Modules' section, which is
at the end of the document, provides every detail about the layer
including that of 'Programmable Modules' section.

Since the brief summary of the layers at the beginning of the document
has a link to the 'Modules' section, browsing to the section is not that
difficult.  Remove 'Programmable Modules' section in favor of 'Modules'
section and reducing duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index f7029bc840ce..39e686c6862d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -33,16 +33,6 @@ DAMON subsystem is configured with three layers including
   layer.
 
 
-Programmable Modules
---------------------
-
-Core layer of DAMON is implemented as a framework, and exposes its application
-programming interface to all kernel space components such as subsystems and
-modules.  For common use cases of DAMON, DAMON subsystem provides kernel
-modules that built on top of the core layer using the API, which can be easily
-used by the user space end users.
-
-
 .. _damon_operations_set:
 
 Operations Set Layer
-- 
2.39.2

