Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FC155757;
	Thu, 19 Dec 2024 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581021; cv=none; b=DxsvEFsoOXQHl9HkwdqhqMFO9XShICuXPFjrU1Pef9k4R2ZQgsUlzbJhK5pGgSlS2nM/AxImIodYSQNouT3EStBMAU62m7vcQWtQimnEYURuBVfTNjZTrfgr0arvmao30rWMf+yT9HiFRNS/J3Gj4WPU9zM7pHWObAIeFPSIsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581021; c=relaxed/simple;
	bh=jJiLMSjkfkiYNfqxKD0GDVmVQI/aoRtBVTgnj8eD1Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoKNzIs5If4RLc0NMDpfHcwiToLUuytGCpk3vUUechn1DwpSdCPzcMr8Wp2hlO5NzYPCKlcepLoOSWuwvxv2mKYmI2WrJCGkW09LmgHyvyhFpPqGhsBEOoPWVB8Qdq1y6jNsIG2lJBwN2qIk4jM60QE+HhsTyNex/AE+hr2YQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDkuN2WL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDkuN2WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D141C4CED6;
	Thu, 19 Dec 2024 04:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581021;
	bh=jJiLMSjkfkiYNfqxKD0GDVmVQI/aoRtBVTgnj8eD1Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDkuN2WLlnPgAv//q0xBglbG9EYR/cthGZiW6EjWvwpjvDkvLFZ7FOr/ikOteFVGQ
	 XDOOUzXbBvMQ7dShJAEdkCj7SAKSC+36QxfDZcPkvWQWvhFkvxJupX4yrgRw0r6GQj
	 T73a31iyJ7UEjMOJOECkvHN6rqie35KwSCybo2DW0J7JnS/NzGdl/mHl9DlMLz5vFw
	 C0a7AuuiR0DHE9LaykwVt/MDuB+V4KJ86y8lKd1uYjkvbTBoHF1GnnTfRaYC5B2rAW
	 53TuNslNJMDEBd7yFyOnzx6isEwGekyXbfiw1eFd3Qzw1RdHUhOqWAdkBc3ex3sJrK
	 72M4g0EN5xjeA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/18] Docs/mm/damon/design: document DAMOS regions walking
Date: Wed, 18 Dec 2024 20:03:11 -0800
Message-Id: <20241219040327.61902-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS' regions walking feature is an important feature for efficiently
retrieving monitoring results or DAMOS-internal behavior.  Document it
on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index f9c50525bdbf..a577ae40e71c 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -540,6 +540,17 @@ To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
 documentation.
 
 
+Regions Walking
+~~~~~~~~~~~~~~~
+
+DAMOS feature allowing users access each region that a DAMOS action has just
+applied.  Using this feature, DAMON :ref:`API <damon_design_api>` allows users
+access full properties of the regions including the access monitoring results.
+:ref:`DAMON sysfs interface <sysfs_interface>` also allows users read the data
+via special :ref:`files <sysfs_schemes_tried_regions>`.
+
+.. _damon_design_api:
+
 Application Programming Interface
 ---------------------------------
 
-- 
2.39.5

