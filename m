Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBA3451BF;
	Tue, 16 Dec 2025 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872124; cv=none; b=nfK7ZEYXBbUwaf/pksmVIA35q3FNmJxvNCQ3YQ4yO6G8fCFUZ68wNUsUQFG1c4GeIYqWnSsyMitczJYFJGaItGpcwNplF/hJtj+18wcbO5FmiH6ZemeQLcPm2sfKmFpdZ5gaZZ+VYlZKi2tHHEAeLrLJuoLWuWS8LddmIsWIfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872124; c=relaxed/simple;
	bh=Z294j8tQ+uhgFiZieSNAE5/gve3h32Q0RHDWAYvQ4ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FloY7jU9WwHmH/uoPCHY6Vct4bYs2tvwgyxjYIjuKEdt28vR7q2ZezcPKE42ROLT+W3LyUDpCmP4lTX0eCeKT+wT2UjjO6jvyWn5lE77XePxvvt/xycJWeNKoTEHG2T1kD0QYO6a+fitFIl8Y7/Y+o9DV/OV5c2gosAdVOwtCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXDV+jGv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXDV+jGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E980C4CEF1;
	Tue, 16 Dec 2025 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872123;
	bh=Z294j8tQ+uhgFiZieSNAE5/gve3h32Q0RHDWAYvQ4ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXDV+jGvJc0fSESzG5TJkcX3/zacToRGcwhCH9SZbpJO/JarzFRnpNAzE4W69oT4P
	 rPDMGTbNR5NGj1Bfi1wVDq2W7OKRBxbzBKg9HUmwF6BEwLx+ZEvpiMq7Yx4lgPR+2s
	 1bJI+P/K72A8zYTLN/ZPdbO9q4+cX+Ej5dyrNE+HFs23GBUyUWOnTqLwppG/kGdwVw
	 2se9p6L7hOdPoa5v62xJsb0o2cOwytCeq1mjAI9LtpAR/X9s6MGXI2zbqP90vHVVtl
	 4A9k/v/GXc8gjzNuMlB3Gt9shwv/DjfjAxW/CuI3NrW2JAhO6af/CgRy1nQLibasE6
	 fhdsaIfM3mQWA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/12] Docs/ABI/damon: update for max_nr_snapshots
Date: Tue, 16 Dec 2025 00:01:24 -0800
Message-ID: <20251216080128.42991-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMON sysfs interface
file, max_nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 7571aa78b7bb..f2af2ddedd32 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -522,6 +522,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the total number of DAMON snapshots
 		that the scheme has tried to be applied.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/max_nr_snapshots
+Date:		Dec 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number to this file sets the upper limit of
+		nr_snapshots that deactivates the scheme when the limit is
+		reached or exceeded.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/total_bytes
 Date:		Jul 2023
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
