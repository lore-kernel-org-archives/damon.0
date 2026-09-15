Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B203DAAD5;
	Tue, 15 Sep 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484848; cv=none; b=d2RmysjFMipke4ibtJrOB1hUeTuY4O5YJsw6zKNcc2GPsJhkjB9wiYHCq7h7vAf+vGAwHnPVMCSdeOiDG6pIBHfXorBld+OKb57S3SO/MqDtuinN6fUEIkvFlTXZa29Iv5/xnSsxKQRlm2YL+IfI1/NrApdrqUvUHLL+4J9gjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484848; c=relaxed/simple;
	bh=N+pgU9vzJZ5Tb7hpSpYd1cFhgq0mVFCUpi+aX2vcWSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkHcCFGYjKdNIEq8SBKCtYzHs9dm5NVknob3SBetbgtjPwtfym9XHknQ17kaYXtU1QgcUb6KdPn5ZffiYo4h00A9XWrlXvOJySZMf2mYASEX8xUf7jyzlQ6aD8k/5K/grezCJZwjljHk6FiRKOKzhzRy7M80P9e57BeXL5kZPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or0xFmsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or0xFmsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551151F00899;
	Tue, 15 Sep 2026 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484846;
	bh=n2oo1YTQM4+/pZ9cxl8HYREgNTNlerD/1V9/5x3e0ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Or0xFmsUWVc1VE4V2yWed5RpVwtOQvRKaTdcug4QpmzHJ0yC2sEn+uNkZ32cudyS/
	 1GmD0pTyiWTP4l/Qq7zLYPE8RRpHWPZXroVA3cDpt+xtKjX9IXnTGbLhZd+8HBrM3V
	 odII4vBCL2IchrJmlhB+Y0/Kip/ak4oWvbxE0J9IIZY+JY5GODUNAAykqJtSG2PhXd
	 NWm1+cbdvSDDKWN4yExQ6X9qVizExG0Qu9EHNK/iXZsnqt6ZBunM1nyVKsY5YJipJO
	 /65vjFxM1dZygGKHoCPVebDkvIIQmxCf1kCIz/ruPz6xq3FDYsJTMnGGDwXvPKEkzD
	 j50s36LpqYwow==
From: SJ Park <sj@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com
Subject: Re: [PATCH 1/1] mm/damon: fix typos in comments
Date: Tue, 15 Sep 2026 08:07:18 -0700
Message-ID: <20260915150719.95470-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915102746.647-1-adrianhuang0701@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 18:27:46 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> Correct spelling mistakes. No functional changes.

Thank you for fixing those, Adrian!

> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
