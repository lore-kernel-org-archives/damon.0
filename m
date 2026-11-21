Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294827;
	b=VBa33wyQN2TqA/DPuW8e2NLtAco7/lNhQwatLylAo/kV3q9+GI+AJhfBgQnhPj0W2N7z
	 iLomonlcuR+xlf916jnt+SzgBI1xcUN4QDAcZTcsBl+Ne8WjYYeTcYdo+ML/zKuo8QcdX
	 nfqFVJ3uHQyT6gjPhGpHzrrdqfKzpZQ0l1907gIoBiwkmbctv7ajQ+TmxUaemASrYZKiL
	 1TaIYF4yrKTkcSwMs2Z3fP6WV4eAr6shOS9+5yb/FDRNddDnDrdJMKZBNwih+G5vet/RS
	 M/oLQ7QovMo6kZIFadeSBTx3O1jWx6x6MJMShxQNAI2pHPQk2Ch0oZW49zcScW1qHHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294827;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xhM0wpvk6HrSV8qT7cTup9dT9Z84UAe+LdIPivh0Pb8=;
	b=rhljBHiU9fafEsxGNCZpkZ3h4E4umVuWbP5n0AsdaUYqQ6+5gBLuz53fxwP/fEcrgaKl
	 4ZJ0i8q381kmDY31q8a+AxAfbNd+v5q4ibjYCrgn/Xze2AWyrvlHGmlQJ5TmaTJiXANWk
	 tQz19jYMSB9PsawN/MWfZinlEQ69dz5VvLuaUDC4xsa1lq20wKv/T43q0MahQ1nuJEKCc
	 w6xoyjrjEj3FmOTiF1u7nfwzF2dvMk7fQ35SH/S86/QaXa5UHLdzOq8FD3kgSxcpgf1Ek
	 LkwOuK27fWAR4TeTREuAV00kghpwAKMmDkort/F8vgrC4+g/uUOUk1XSxoveE69WYlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FACY3Odv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C7606A32C;
	Sat, 21 Nov 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FACY3Odv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF65D1F000CF;
	Sat, 21 Nov 2026 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294827;
	bh=xhM0wpvk6HrSV8qT7cTup9dT9Z84UAe+LdIPivh0Pb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FACY3Odv8r8pIhtlCkmgl3mTj84UPmuLOl2P7+rvoftobP2l/q2H+iQGRMrcRlx45
	 JJVvRFZP0kmtptPOCp1jsZD9HLGjnBh6TlegADLDlMY5+ySjo/68pzLQn/sXacZY4E
	 A8VoHGDa3TJKzikoQPZnrnzWj16vYt+/V4OWZO5KqZEM2wovcftipk98+PQkbP4Kb9
	 fZi0lKa0hILTAT+f0aq9JR+8V++CtkBipB6DSQ9sNAU476rufq/6aeB9WzoauxIiWW
	 UeuGcLsJekDK3rne/4k4Q1Mkem5ZTbqs30kSmgqz/xFjtiX+wrlID6k6+Zb9NLAk5o
	 wdX9aMy7STQOA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 17/27] Docs/mm/damon/design: update for report_made probe filter type
Date: Sat, 21 Nov 2026 13:00:01 -0800
Message-ID: <20261121210013.130397-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added data attribute report
existence type probe filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5a75a69021a48..31ca623385718 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -303,6 +303,8 @@ supported filter types.  Currently below filter types are supported.
 - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
   of a given size range.
 - ``active``: Same as that for DAMOS filters.
+- ``report_made``: Matches if a :ref:`report <damon_design_attr_reporting>` for
+  the memory is made in last sampling interval.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -382,6 +384,10 @@ depending on the type of the report.
 
 For now, no report type is supported.
 
+The data attribute probe supports the reports.  The probes can be configured to
+hit for a given memory region if a specific type of valid reports that are
+associated with the probing memory exist in the reports queue.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
