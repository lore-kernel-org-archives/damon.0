Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDC1F461D
	for <damon@lists.linux.dev>; Fri, 11 Apr 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389189; cv=none; b=U/+ZW4JFinAaoyGczWbFuGPhfc7E7wIJXOO6wjDB2exCFs8ndf4hTn0dQ2yJANrUVQwH/Hoq1J6MZG70OLZxDtlOGIOMT7shTv/HLBl8Ab6Sqwtk9fWZe81Cd4QxUdTwU0epn13SVd7zCXc6mfUA2Vb9h4zrbcy9019QFYj/fsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389189; c=relaxed/simple;
	bh=/gIFbGVXjUsaBPC1hRG6gKFQlic8yuonYXu4BZJ7T+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcdhjIbG7plW2OljWCyYSR7/aExPHk7gJVwBshfrxnVtyTCj93ndbdgu41GFeubcJMort3sNV4zVibi9owUjiOtIiaIJwoy7dMAq+p8HHgxfK5U0hiUBUt2IDV9qEampJ2ZLITiR4Y3jD78KyshUPeSUL0v8GhTh3Y7zlNrsuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZEb6rsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZEb6rsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C88C4CEE2;
	Fri, 11 Apr 2025 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389188;
	bh=/gIFbGVXjUsaBPC1hRG6gKFQlic8yuonYXu4BZJ7T+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZEb6rsHm83rqmd2O30L34ZkjHnNLRA4+lZtkUGO/uF8xBK3xZG0C+I7H5O4ovnZp
	 0exSPcjyX19/CQyF3CXPL67mwpRYeMFPCR4lieESupOZtpLXGgBrVIb0Xx8PAaoZVL
	 BKDC0Sa6xsjBJzEM/yfOLp6CW+FgWw9P7aR39G7G4Yz88yMiCBfCKRGNwhNOqxgn1/
	 IN2r5gECDprfljPNDUUO9mggsTB164b4RqFIOGt2H+lUPfVk/NUlsgsqfl/z+MHYpk
	 trc8IF3V271EAPl9lMQvFglFDsXp20q00YV+Mm46llMwwqKP2ajvxOdqN7jAjMitxL
	 ea7HiNeMcCb0w==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <enze.li@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Enze Li <lienze@kylinos.cn>
Subject: Re: [PATCH] selftests/damon: Remove the remaining test scripts for DAMON debugfs interface
Date: Fri, 11 Apr 2025 09:33:05 -0700
Message-Id: <20250411163306.64948-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411024332.1373861-1-enze.li@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 10:43:32 +0800 Enze Li <enze.li@linux.dev> wrote:

> From: Enze Li <lienze@kylinos.cn>
> 
> DAMON has dropped debugfs support; therefore, remove these unused
> scripts.

Nice finding, thank you for this patch!

> 
> Fixes: 5ec4333b1967 ("mm/damon: remove DAMON debugfs interface")
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
