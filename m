Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43794849C
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415128; cv=none; b=iUEMATCKLgLt8/fhvuLdqSmNdmG+dcZ8gwV25HePa+8o53H/1YOnZMAb0hJRmSfFi0H6/h2S4J+1xJ6uQK06iO0+ZzwJEjWXQkUVAj989pHZNB64tze5OYY8g61iXeU6lPVzBC7v8GiKYHiqsbr3X6/G115duEDa+pdfAFDSWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415128; c=relaxed/simple;
	bh=9M6H/aifoCUKwuC0rptHtdBZsDlS72B3swWOIoljHlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dG40cwgErNy8Knzado18Si67erogg1FloMyLs42GWg98uvsU0+fBV+oH/ad+XdY/GS49iDUOtOBmV+yIIliE4tltP5zm9AvIUlN4tYN3j/ACCMtWwCfB1mDKA2vC7F/pPb4TEYqThmE0/M+8ttXT1lLuiDzJYDFT57t0h5iJALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9Zw80FB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9Zw80FB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44D7C4CEF0;
	Tue,  5 Aug 2025 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754415127;
	bh=9M6H/aifoCUKwuC0rptHtdBZsDlS72B3swWOIoljHlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9Zw80FBGLYJezDB/tqLgH/kZAcne22SkYTVFvvJb0f2xJCMjkebA0KPlQbMFXdiO
	 OyknCgPN1gdOnmb9sChaTg5YbhlXk3RESZfsiFqXRtjr4bJO5Q2ASML8uZFptkBuQg
	 HFdX9Ifh3HuI/UHh84mheGK+KQw/gEcYZLT6IZZtK4s0FcvFZmjLt7YKLNj/o75m+s
	 UFGckUHDEX9q5lpXUbMAUw7BM2fch7p60E71GJFATJ6xaTDkwiZa1FSXt3/hDeaeNu
	 HQYx0zsssHJpx0hIi89yAdAR+hCKFHoXe1K4ZQxeCAZt17IpbTKjGTQ/flb1G1Cglf
	 Y9GCTryhbD/gA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/damon: update expired description of damos_action
Date: Tue,  5 Aug 2025 10:32:05 -0700
Message-Id: <20250805173205.7385-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805123940.13691-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  5 Aug 2025 21:39:40 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Nowadays, damos operation actions support more various operation set.
> But comments(also, generated documentation) doesn't updated.
> So, fix the comments with current support status.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
