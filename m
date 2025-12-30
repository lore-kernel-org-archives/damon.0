Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A62DCF67
	for <damon@lists.linux.dev>; Tue, 30 Dec 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767056241; cv=none; b=poGj3Ggs3v37Epi6R/2M0ft9Lo6MHljd4log7KkP3fXK5q9mdVu/7vyM5eLIaF6QwAOGfIKva5ouuC18G4r0sDnHknywhPh5mwTsOPyacG9aRMxC+Ib+oHflJWblWSsQH7HGSteghRmMcaCKU5T+9OlGL0lNkuV1UAZd5R9d4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767056241; c=relaxed/simple;
	bh=ABitZlA6pWrBbnmGARMlUJQ1EKCA3LyUITLpALBWMws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JglWAzgbZlpS6p+edqLry/XeXCCZ2Yl2iLEt+3lWwX/zF6fkGXGGgFcCE6BY1FrAC7Pq+WocajwMOVkHWrpP/gEQ7s6E+AxrLOV+JFe8bm703o6PP1cTm9gz+YHeCFt0AIiDWswfYW75MHTLl3LHsQcQ4M7xUr7XixJiDUPdvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAXJeUIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAXJeUIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2608EC4CEF7;
	Tue, 30 Dec 2025 00:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767056241;
	bh=ABitZlA6pWrBbnmGARMlUJQ1EKCA3LyUITLpALBWMws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAXJeUIWr31dlu0uE7PzO7zGrqXoJuxZj5Pus790ITBskoPoBxaMo6pVDq6oVDE4u
	 EscmWo4deN+eMOTNgxdOIL1+cmaZJSaDvMueh3vAkAZ/VDTONRPvSwD1Ke1p7tmqDL
	 iEr7hifloPMVGT5S3o3gRPG3GWeq7MeQTz1ThInONgPHT9dg2kaCkjjnItTHo8ghG/
	 yWe6LU3NDlAgsjTvWssY/H0u28Q7W9Ga5d7R+D2KGvOZ5J8OmLx3Wqo5aF++QvSCPS
	 QVnuH/eNb+tBRMip8rzaLGyOSkIgwAe1HVVtNkb5IONLv9MCUwk5Cu15k30nRbPgkN
	 GLHXauj7uL8sA==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
Date: Mon, 29 Dec 2025 16:57:15 -0800
Message-ID: <20251230005716.47160-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC7ondk_Gjhetb7Wtsz60c1dRmt_h9MwT8uwh0vwaktDLw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Dec 2025 09:14:37 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> I will reflect the above in patch v2.
> Would you like me to resend patch v2 ?

I just found my fix [1] of the bug that you reported has a race condition.  And
to fix that, I think kdamond_call() will anyway need to be modified.  I will
shortly send more details as a reply to the fix [1].  Can you please hold this
refactoring until all discussions about the bug fix is done?  Sorry for your
inconvenience.

[1] https://lore.kernel.org/20251228183105.289441-1-sj@kernel.org


Thanks,
SJ

[...]
