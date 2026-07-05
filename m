Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7A27603A;
	Sun,  5 Jul 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269978; cv=none; b=FgxHW0tA6LgviIopVM1CvxY5Nl5pchvrPKkGMb52TR1VHXeUf87G3s1ktvc5LPqp2sCdypAqltMiQovEqGHffzSO7/QQ++NvG57TWSRK5khJkCNMxBgDaPLrqnGg+7m+fqNlwtsi/qPWXLCEp+ZQCfQ/9ovKzPaZ0TGJpFv3S+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269978; c=relaxed/simple;
	bh=iKmRDnzo2/awq4mUVSAQEaFJxKYJEb7zh9D/2dtbnN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeSW+sfjMsHRAhmnOXP8n+Yrt8zzE65OsFprXcIfstHKxLinsW/PFamwqbVqFnLHmVy/MOezbRmy6HoJvXbYhZv9LcbGgWroV1snGLqTw/bUG/gdbwJMeiKh4fMtaS8Cg0npC4Xwa41In1I2fwRpwTJGswV9hELdU66LBM38K8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUGvEzOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUGvEzOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA641F000E9;
	Sun,  5 Jul 2026 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783269976;
	bh=FESRrFcEtdwNqKL1s9XBnIxVyPUQKtn6yOvnf578D+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUGvEzOQVo4/k4asBm1+I2+tQ9SWJ3LTarop3/OlvP702vTOm6szEP3SJvZToZRVP
	 bisQ8f/T8gKqGLgD89ZoVl9j9nVfyhhRfo/6nmlDJYo0sFNFt9YGRzjSc7NW1uIMES
	 jfCByLy8QFfLuLNelNgPZzLu7H9zZvSJYaOC3WasPrEOYJ65REy0f10yLmPX/MiHeT
	 vCOQxXK/01G+2OVkLAJTLnUdrxouSW+luhuDBnBJdfBkTEWzo602htJw/LCsYi0CUE
	 yrQobQ6AO7Hp0FYraj4PNKCfs8sEjoZkH0IhxC8K76gamRU2hU7iVW1dFMIRv0+cBa
	 0R2t8ZtQkEFPA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: validate all parameters in the core
Date: Sun,  5 Jul 2026 09:46:08 -0700
Message-ID: <20260705164609.101994-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  5 Jul 2026 08:55:51 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON has a number of parameters.  Some of the parameters are validated
> by DAMON, while some are validated by DAMON API callers.  Each caller
> has their own set of parameters that are exposed to users.  Hence each
> caller has their own ways to do the validation.  There is no clear lines
> for the responsibilities.  It is confusing and easy to make mistakes at
> validations.  Actually we found a few bugs in the class.
> 
> Define DAMON core as the place to do all the validations and implement
> those.  damon_set_regions(), damon_start() and damon_commit_ctx() are
> the three main DAMON core API functions for setup of DAMON parameters.
> Make the three functions to do safe and holistic parameter checks.  The
> first one is already providing the validation, so changes are only for
> the last two functions.
> 
> This might add unnecessary validations for some use cases.  The overhead
> should be negligible as parameters update is expected to only rarely
> happen.  It reduces the number of places to check and fix for bugs of
> the class from all callers to the single component.  The maintenance
> efficiency gain is obvious.
> 
> Further cleanup documents and caller code.  Make the lines of validation
> duties clearer.  Remove validations that are no more needed owing to the
> core validations.

Sashiko found a few things but those are not real issues in my opinion.  Please
read my replies to Sashiko comments on DAMON mailing list thread [1].

DAMON mailing list is opted in to Sashiko finding mail delivery to the author
and the mailing list.  I record my opinions to those by replying to the thread.  
Hence you can show the detailed opinions from DAMON mailing list thread.

[1] https://lore.kernel.org/damon/20260705155600.96555-1-sj@kernel.org/


Thanks,
SJ

[...]
