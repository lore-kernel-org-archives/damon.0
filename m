Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5A339387;
	Wed, 22 Jul 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729157; cv=none; b=cdwAfhY8ZHhUsWdm8gQ7lTasAXBuzN6twPbImsQj0y06qbg1eeEVRAAwp46bTdRLuN1nju/+d90904FaxkqSUH6CcPYwdft2bKIHNufIG8C4VW/FoLQRFhm+I33U3pWAOXvZN51WHZH42xvfdEouaPztllYDGMVw+jasRkPAD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729157; c=relaxed/simple;
	bh=nCvIeIyy4L3uRVnCFk/u2y87rmvaIhs+3/JXJbXYjBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O00sMTb+2NhJGVeifAarZzpDmdgYw8EOcG3xeGUG+TkbVCuBb9zDpukQaz5alBwIBg9/pAD9LJsnsijXWlF3+7zmPP7cg2y3bRScXfFvA4a8FYBIKDVGf5Vdfd7UI5aSIsZ3i5GpkDK1Ad93aKIJJX84883BuKsVyIXLz2QXPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8yTBpCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8yTBpCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687041F000E9;
	Wed, 22 Jul 2026 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729156;
	bh=CdWv5bw+MY0yLpnXKBhDLO1smov7xMcfQOosrjv5JaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W8yTBpCPXZTphyTItF9YAy6BinPK3E8PxOwuzYe7TlP9/Kd8q/7C9CR6O4nsIy4vC
	 rpEyat81AOAb/shtHpatDgHeHqfCRBeR2CfEiLBQrbfzxQi9Ms9NrBs3oAynx4jyYv
	 3nx7dn+CnCMxj1gpHSCytP9NuFPWcJVD9iIIbhNUga6gtQ/w+8iIeCKJg3MayAjH2p
	 J8Baq4phIDvKaV4umR764EcwZi3FgDuJE3V++T6Iu+jlJqdjcJrpQCpSNoL4fiF+qX
	 p7oyy/WFolz+WmGO3vUKpzccT3od19qHeUo2BJeQRo79vxQ3PHaF67F+oxnDkXahHO
	 gJ2SLEFKyHv8w==
From: SJ Park <sj@kernel.org>
To: Cheng-Han Wu <hank20010209@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/2] mm/damon/core: remove unused damon_nr_running_ctxs()
Date: Wed, 22 Jul 2026 07:05:48 -0700
Message-ID: <20260722140549.91106-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722113338.302603-3-hank20010209@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 19:33:38 +0800 Cheng-Han Wu <hank20010209@gmail.com> wrote:

> damon_nr_running_ctxs() has had no in-tree users since commit
> 5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
> all of its callers.
> 
> Remove the unused declaration and definition.

Nice catch and cleanup, thank you!

> 
> Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
