Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669E146A66;
	Sun, 28 Sep 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080390; cv=none; b=Fv2vjqTY89S18Gf49gkaXQD8MaC7WmQI4/SKPYNqtMUJmdroev82RQZH5KmVkT7NqBi9MOz+sH0jbL2gxEfC6S8EjcHaf6fGN/w9WClW5Maqp6cwG1Fk7pn5DYkdYMfWr7fjktfrETNBI91eNQcy+IiHBwDf25pMZvMfTCmC1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080390; c=relaxed/simple;
	bh=OF7eWJ87Kl5LRzmJe4NN5nJVmgj/D1ixJcTK5JUoabw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UL1HCks7DkRni9JMbtImIHKKMXEasX7+VETnOhXcXYcp3ZtBYDgzfrLErul5yi6YwVT95qQ2O6vMDXxykgJ3LutXKPvBx9GoBWgyybrWWDz8ULFxn8PFHSS5nEkfDKtXdOJg60etbuvG/9ttCy6i9ggQUHXH6sr5pEpgHvkVgVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+wJ1ZRP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+wJ1ZRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5A1C4CEF0;
	Sun, 28 Sep 2025 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759080390;
	bh=OF7eWJ87Kl5LRzmJe4NN5nJVmgj/D1ixJcTK5JUoabw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+wJ1ZRPdGfWAT3/SWUywCk8+MFsU+4tQrSBZnYh/+goYOtPVPlKJO4mKVuhn3QUX
	 9StVYWd8OrqqQQN/kP2tml9MXZpp7WXgsA8iEk71jFoIh7gyHBZ8gDIOlFR6REW7to
	 GYMuDeYjFuvzFj0qBAuwVW5Outbcju1VZJtHT7LoFtnHQidx1MSPSQrGJQIZWdr5AX
	 ZeztRWJdsTftWwUt1KnSGHYld2z7dKRLuzMvrSJTOpMNGBCdgA98amQjBuR3sk8OrA
	 Aq/HTL+uI8+A/eeWIs6QUj7EomLXPWuDD8d2mk9uPwqbi40vO2mr7SUVu7Hw/+Zt+z
	 LukmsUuTbcosQ==
From: SeongJae Park <sj@kernel.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide/mm/damon: Correct typo "directores"
Date: Sun, 28 Sep 2025 10:26:28 -0700
Message-Id: <20250928172628.61235-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250928064651.281325-1-weibu@redadmin.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Sep 2025 15:46:51 +0900 Akiyoshi Kurita <weibu@redadmin.org> wrote:

> The word "directores" is a typo in usage.rst. Correct it to
> "directories" to improve documentation clarity.

Thank you for fixing this!

> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
