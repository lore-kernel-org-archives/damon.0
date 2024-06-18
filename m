Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8717E46A;
	Tue, 18 Jun 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746595; cv=none; b=r8iiSwJACjGuiMXkpO2XGmYtV6O3ZAScH8oAEL9kWE/eNHWvZO/u90Bhs7IFg+A3K/qSgrNBJqcJD4lifix1zPnlMYPnGT4cKkzfdrLFy7z75GtjssaIGD6Nyv77bT2TF3KAE0DhvEOo92i4nKKj4hLjdqUbkY+VtBFqzONVM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746595; c=relaxed/simple;
	bh=QdAgvz/eRFgxbWjUE+6h9i06/YLLhBFGTN2aDiUR8OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qq1B8Dw+DNor+Lvg7YALgSX/WOPi1aH8wrgBMqi91xDNsqEc0BcPsHKP9/Bflq+0lxCjgJWEVEFqTm/L3eIcCZ6CANli+RS2UYPJ33w7O0LcfOLC6y/6T+JlRYZuOI3T6vVXhTSl18PN06TsojUU9P0XbdSTAXfE9M6mqZSOqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjvXziCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjvXziCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396E9C4AF53;
	Tue, 18 Jun 2024 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718746595;
	bh=QdAgvz/eRFgxbWjUE+6h9i06/YLLhBFGTN2aDiUR8OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjvXziCtoMIheG1gqO2FDGiBd/Ryq4bLZy4eL1bflr6mBUjdb7pfyhrxK6vADKrru
	 TJlxPkaziIoxsFJP+Ig0ZBuL+2ZtbbCX1WFETMaoF+TE+cQ5lW70XjNDmzMc49HZwe
	 JAQ2lS8w7NwGfeYBwGiUW88ouEavyX/WUrkn88UWzt20zeNM23UoQzjso7Z54BSVq5
	 IwbIthcaDi9P272x0+e2WpZHZ1Y0Pk7y/PzHHXrZVGlnOhSO0+vsUCR3SpudDewQoW
	 59/ReIQjigqq5uC2494TpVKfap+w+7V8XqJlw2I9M1O9FvlUQguATKMCylpGI9+1wL
	 I1LX6eTlW/+AQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Docs/ABI/damon: document target_nid file
Date: Tue, 18 Jun 2024 14:36:30 -0700
Message-Id: <20240618213630.84846-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618213630.84846-1-sj@kernel.org>
References: <20240618213630.84846-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document target_nid DAMON sysfs file that introduced for
DAMOS_MIGRATE_{HOT,COLD}.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index cef6e1d20b18..f1b90cf1249b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -155,6 +155,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the action
 		of the scheme.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/target_nid
+Date:		Jun 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Action's target NUMA node id.  Supported by only relevant
+		actions.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/apply_interval_us
 Date:		Sep 2023
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.2

